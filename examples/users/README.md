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

# Running users module on multiple iDRACs

Configuration in this directory creates/deletes/modifies users on multiple iDRACs.

## Example inputs

terraform.tfvars
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

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```
To update details of the created users, once the changes are done in configuration file, execute:

```bash
$ terraform plan
$ terraform apply
```

After successful operation of above commands, to delete the above created users, you need to execute:

```bash
terraform destroy
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_users"></a> [users](#module\_users) | ../../modules/redfish_users | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_idrac_local_users"></a> [idrac\_local\_users](#input\_idrac\_local\_users) | n/a | <pre>list(object({<br>        user_id = optional(string)<br>        name = string<br>        password = string<br>        role_id = string<br>        enabled = bool<br>    }))</pre> | n/a | yes |
| <a name="input_idracs"></a> [idracs](#input\_idracs) | n/a | <pre>list(object({<br>    user         = string<br>    password     = string<br>    endpoint     = string<br>    ssl_insecure = bool<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->