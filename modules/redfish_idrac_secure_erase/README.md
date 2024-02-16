<!--
Copyright (c) 2024 Dell Inc., or its subsidiaries. All Rights Reserved.

Licensed under the Mozilla Public License Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://mozilla.org/MPL/2.0/


Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

# Redfish iDRAC Secure Erase Terraform module

Terraform module which runs ISE (Instant Scramble Erase) on physical disks managed by an Dell iDRAC.

This module is a wrapper around https://github.com/dell/iDRAC-Redfish-Scripting/blob/master/Redfish%20Python/SecureEraseDevicesREDFISH.py
On `create`, the module fetches this script and uses it to check if the devices support ISE and fails if not.
On `destroy`, it uses this script to run ISE on all the disks.
The script, in turn, uses HTTPS Redfish API of the iDRAC.

## Prerequisites

| Name | Version |
|------|---------|
| <a name="requirement_idrac"></a> [iDRAC](#requirement\_idrac) | >= 9.0 |
| <a name="requirement_idrac_firmware"></a> [Firmware](#requirement\_idrac_firmware) | >= 5.0, <= 7.0 |
| <a name="requirement_git"></a> [Git](#requirement\_git) |  |
| <a name="requirement_python"></a> [Python](#requirement\_python) | >= 3.6 |

## Usage

See [`examples`](../../examples) directory for working examples to reference:

```hcl
module "secure_erase" {
    source = "./"

    hostname = "my-server-1.myawesomecompany.org"
    username = "admin"
    password = "passw0rd"
    ssl_verify = false

    # exactly 1 among pdisk_fqdds, controller_ids and controller_names must be set
    pdisk_fqdds = [
        "Disk.Bay.1:Enclosure.Internal.0-1:RAID.Integrated.1-1",
        "Disk.Bay.0:Enclosure.Internal.0-1:RAID.Integrated.1-1",
        "Disk.Bay.2:Enclosure.Internal.0-1:RAID.Integrated.1-1"
    ]
    # controller_ids = ["RAID.Mezzanine.1-1"]
    # controller_names = ["PERC H730P Mini"]
}

```

## Examples

<!-- - [With physical disks](../../examples/secure-erase-physical-disks) with physical disks.
- [With storgae controller id](../../examples/secure-erase-physical-disks) with storgae controller id.
- [With storage controller name](../../examples/secure-erase-physical-disks) with storgae controller name. -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.0 |
| <a name="requirement_redfish"></a> [redfish](#requirement\_redfish) | >= 1.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6.0 |
| <a name="provider_redfish"></a> [redfish](#provider\_redfish) | >= 1.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_id.dir](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [terraform_data.git_repo](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sec_erase](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| redfish_storage.storage | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_controller_ids"></a> [controller\_ids](#input\_controller\_ids) | List of storage controller IDs to run secure erase on. | `list(string)` | `null` | no |
| <a name="input_controller_names"></a> [controller\_names](#input\_controller\_names) | List of storage controller names to run secure erase on. | `list(string)` | `null` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname or IP of the iDRAC. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Password of the iDRAC. | `string` | n/a | yes |
| <a name="input_pdisk_fqdds"></a> [pdisk\_fqdds](#input\_pdisk\_fqdds) | List of disk FQDDs to run secure erase on. | `list(string)` | `null` | no |
| <a name="input_python3_path"></a> [python3\_path](#input\_python3\_path) | Path to python3 executable. Default is /usr/bin/python3. | `string` | `"/usr/bin/python3"` | no |
| <a name="input_ssl_verify"></a> [ssl\_verify](#input\_ssl\_verify) | Whether to verify SSL certificate, default is true. | `bool` | `true` | no |
| <a name="input_username"></a> [username](#input\_username) | Username of the iDRAC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_physical_disk_fqdds"></a> [physical\_disk\_fqdds](#output\_physical\_disk\_fqdds) | List of physical disk FQDDs on which secure erase would be run. |
| <a name="output_temp_dir"></a> [temp\_dir](#output\_temp\_dir) | Temporary directory used by this module. |
<!-- END_TF_DOCS -->