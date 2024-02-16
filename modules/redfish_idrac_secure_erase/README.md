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

<!-- ## Providers

| Name | Version |
|------|---------|
| <a name="provider_redfish"></a> [redfish](#provider\_redfish) | >= 1.2.0 |
| <a name ="provider_local"></a> [local](#provider\_local) | >= 2.4.1 |
| <a name ="provider_random"></a> [random](#provider\_random) | >= 3.6.0 | -->

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

<!-- - [With physical disks](../../examples/secure-erase-physical-disks) with VPC Endpoints.
- [With storgae controller id](../../examples/secure-erase-physical-disks) with storgae controller id.
- [With storage controller name](../../examples/secure-erase-physical-disks) with storgae controller name. -->

<!-- ## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [redfish_storage.storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_id.dir](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [terraform_data.git_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [terraform_data.sec_erase](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |

## Inputs

| Name | Description |
|------|-------------|
| <a name="physical_disk_fqdds"></a> [physical\_disk\_fqdds](#output\_physical\_disk\_fqdds) | Array containing the FQDDs of all physical disks on which secure erase will be run on `destroy` |
| <a name="temp_dir"></a> [temp\_dir](#output\_temp\_dir) | The local temporary directory path being used by this module | -->
