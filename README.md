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

# Terraform Modules for Dell Technologies iDRAC

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](about/CODE_OF_CONDUCT.md)
[![License](https://img.shields.io/badge/License-MPL_2.0-blue.svg)](LICENSE)

Terraform module collection for Dell Technologies iDRAC.
These modules use the Dell Technologies iDRAC Redfish API.

Terraform modules package multiple resources together, allowing for efficient, modular design. They simplify code management and can be easily shared across different projects. For more information refer this [link](https://developer.hashicorp.com/terraform/language/modules) 

## Table of contents

* [Prerequisites](#prerequisites)
* [List of Submodules in Terraform Modules for Dell iDRAC](#list-of-submodules-in-terraform-modules-for-dell-idrac)
* [Support](#support)
* [License](#license)
* [Code of Conduct](https://github.com/dell/dell-terraform-providers/blob/main/docs/CODE_OF_CONDUCT.md)
* [Maintainer Guide](https://github.com/dell/dell-terraform-providers/blob/main/docs/MAINTAINER_GUIDE.md)
* [Committer Guide](https://github.com/dell/dell-terraform-providers/blob/main/docs/COMMITTER_GUIDE.md)
* [Contributing Guide](https://github.com/dell/dell-terraform-providers/blob/main/docs/CONTRIBUTING.md)
* [List of Adopters](https://github.com/dell/dell-terraform-providers/blob/main/docs/ADOPTERS.md)
* [Security](https://github.com/dell/dell-terraform-providers/blob/main/docs/SECURITY.md)

## Prerequisites

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_idrac"></a> [iDRAC](#requirement\_idrac) | >= 9.0 |
| <a name="requirement_idrac_firmware"></a> [Firmware](#requirement\_idrac_firmware) | >= 5.0, <= 7.0 |

## List of Submodules in Terraform Modules for Dell iDRAC
  * [redfish_idrac_secure_erase](modules/redfish_idrac_secure_erase) Runs ISE (Instant Scramble Erase) on physical disks managed by an Dell iDRAC.

## Support
For any Terraform Modules for Dell PowerFlex issues, questions or feedback, please follow our [support process](https://github.com/dell/dell-terraform-providers/blob/main/docs/SUPPORT.md)

## License

The Terraform Modules for Dell iDRAC is released and licensed under the MPL-2.0 license. See [LICENSE](https://github.com/dell/terraform-redfish-modules/tree/main/LICENSE) for full details.

