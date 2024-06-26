
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

variable "username" {
  description = "Username of the iDRAC."
  type = string
}

variable "password" {
  description = "Password of the iDRAC."
  type = string
}

variable "hostname" {
  description = "Hostname or IP of the iDRAC."
  type = string
}

variable "ssl_verify" {
  description = "Whether to verify SSL certificate, default is true."
  type = bool
  default = true
}

variable "pdisk_fqdds" {
  description = "List of disk FQDDs to run secure erase on. Must be specified if `controller_names` and `controller_ids` are not specified. Conflicts with `controller_names` and `controller_ids`."
  type = list(string)
  default = null
}

variable "controller_ids" {
  description = "List of storage controller IDs to run secure erase on. Conflicts with `pdisk_fqdds`."
  type = list(string)
  default = null  
}

variable "controller_names" {
  description = "List of storage controller names to run secure erase on. Conflicts with `pdisk_fqdds`."
  type = list(string)
  default = null
}

variable "python3_path" {
  description = "Path to python3 executable."
  type = string
  default = "/usr/bin/python3"
}

variable "working_directory" {
  description = "Working directory for this module. The module will manage a temporary directory here, so this directory should have write permissions. Defaults to the root module directory."
  type = string
  default = null
}
