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

# Redfish iDRAC User Terraform module

Terraform module which create, delete and modify multiple users.

This module is a wrapper around https://github.com/dell/terraform-provider-redfish/blob/main/redfish/provider/resource_redfish_user_account.go
On `create`, the module creates users one by one, using the Terraform Provider for Redfish User Account.
On `destroy`, it uses the user Account to remove the user(s).

~> **Note:** The idrac_local_users field cannot have empty value; At least one user is required.

~> **Note:** For managing (Create/Update/Delete/Change password) a single user at a time, use the resource 'redfish_user_account'

~> **Note:** For managing (Create/Update/Delete/Change password) multiple users at a time, use the module 'user_module'

~> **Note:** For changing the password of Administrator/root user alone, use the resource 'user_account_password'

## Prerequisites

| Name | Version |
|------|---------|
| <a name="requirement_idrac"></a> [iDRAC](#requirement\_idrac) | >= 9.0 |
| <a name="requirement_idrac_firmware"></a> [Firmware](#requirement\_idrac_firmware) | >= 5.0, <= 7.0 |
| <a name="requirement_git"></a> [Git](#requirement\_git) |  |

## Usage

See [`examples`](../../examples) directory for working examples to reference:

```hcl
module "users" {

    source = "../../modules/redfish_users"
    
    # idracs and their credentials
    idracs = [
      {
        user = "root"
        password = "passw0rd"
        endpoint = "my-server-1.myawesomecompany.org"
        ssl_insecure = false
      },
      {
        user = "root"
        password = "passw0rd"
        endpoint = "my-server-2.myawesomecompany.org"
        ssl_insecure = false
      },
    ] 

    # local users
    idrac_local_users = [
      {
        name     = "tom"
        password = "T0mPassword123!"
        role_id  = "Operator"
        enabled  = true
      },
      {
        name     = "dick"
        password = "D!ckPassword123!"
        role_id  = "ReadOnly"
        enabled  = true
      },
      {
        user_id  = 12
        name     = "harry"
        password = "H@rryPassword123!"
        role_id  = "ReadOnly"
        enabled  = true
      },
    ]  
}
```

## Examples

- [Multiple users on multiple iDRACs](../../examples/users)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_redfish"></a> [redfish](#requirement\_redfish) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_redfish"></a> [redfish](#provider\_redfish) | >= 1.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| redfish_user_account.idrac_local_users | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_idrac_local_users"></a> [idrac\_local\_users](#input\_idrac\_local\_users) | List of users | <pre>list(object({<br>      user_id = optional(string)<br>        name = string<br>        password = string<br>        role_id = string<br>        enabled = bool<br>    }))</pre> | n/a | yes |
| <a name="input_idracs"></a> [idracs](#input\_idracs) | List of iDRAC credentials. | <pre>list(object({<br>    user         = string<br>    password     = string<br>    endpoint     = string<br>    ssl_insecure = bool<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->