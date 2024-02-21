
# Copyright (c) 2024 Dell Inc., or its subsidiaries. All Rights Reserved.

# Licensed under the Mozilla Public License Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://mozilla.org/MPL/2.0/


# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

data "redfish_storage" "storage" {
    controller_ids = var.controller_ids
    controller_names = var.controller_names
  redfish_server {
    user         = var.username
    password     = var.password
    endpoint     = "https://${var.hostname}"
    ssl_insecure = !var.ssl_verify
  }
  lifecycle {
    precondition {
      condition     = var.pdisk_fqdds != null ? var.controller_ids == null && var.controller_names == null : true
      error_message = "When pdisk_fqdds is specified, controller_ids and controller_names cannot be specified."
    }
    precondition {
      condition     = var.pdisk_fqdds == null ? var.controller_ids != null || var.controller_names != null : true
      error_message = "When pdisk_fqdds is not specified, at least one of controller_ids and controller_names must be specified."
    }
  }
}

locals {
  pdisk_fqdds = var.pdisk_fqdds==null ? flatten(data.redfish_storage.storage.storage[*].drive_ids[*]) : var.pdisk_fqdds
}

resource "random_id" "dir" {
    byte_length = 8
}

resource "terraform_data" "git_repo" {
    input = {
        dir = "${path.root}/${random_id.dir.b64_url}"
    }
    provisioner "local-exec" {
        command = "mkdir -p ${self.output.dir}"
    }
    provisioner "local-exec" {
        command = <<-EOT
            git clone https://github.com/dell/iDRAC-Redfish-Scripting.git code
            cp 'code/Redfish Python/SecureEraseDevicesREDFISH.py' code.py
        EOT
        working_dir = self.output.dir
    }
    provisioner "local-exec" {
        when = destroy
        command = "rm -rf ${self.output.dir}"
    }
}

resource "terraform_data" "sec_erase" {
    input = {
        environment = {
            HOST = var.hostname
            USER = var.username
            PASS = var.password
            SSL = var.ssl_verify ? "true" : "false"
        }
        pdisk_fqdds = local.pdisk_fqdds
        python3_path = var.python3_path
        script = "${var.python3_path} ${terraform_data.git_repo.output.dir}/code.py -ip ${var.hostname}"
        cred_args = "-u $USER -p $PASS --ssl $SSL"
    }
    provisioner "local-exec" {
        command = <<-EOT
            %{ for disk in self.output.pdisk_fqdds ~}
            ${var.python3_path} -c "print('Checking if disk ${disk} supports secure erase...')"
            ${self.output.script} ${self.output.cred_args} --check-disk ${disk} || exit 1
            %{ endfor ~}
        EOT
        environment = self.output.environment
        quiet = true
    }
    provisioner "local-exec" {
        when = destroy
        command = <<-EOT
            %{ for disk in self.output.pdisk_fqdds ~}
            ${self.output.python3_path} -c "print('Securely erasing disk ${disk}...')"
            ${self.output.script} ${self.output.cred_args} --secure-erase ${disk} || exit 1
            %{ endfor ~}
        EOT
        environment = self.output.environment
        quiet = true
    }
}
