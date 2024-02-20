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

# Running secure erase on multiple iDRACs by controller names

Configuration in this directory runs secure erase on multiple iDRACs by the controller names.

## Example inputs

terraform.tfvars
```hcl
racks = {
    "my-server-1.myawesomecompany.org": {
        username = "admin"
        password = "passw0rd"
        ssl_verify = false
        controller_names = ["PERC H730P Mini"]
    },
    "my-server-2.myawesomecompany.org": {
        username = "admin"
        password = "passw0rd"
        ssl_verify = false
        controller_names = ["PERC H730P Mini"]
    },
}
```

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```

That would verify that your disks support ISE (Instant Scramble Erase).

After successful operation of above commands, to run secure erase operation on these disks, you need to execute:

```bash
terraform destroy -target=module.secure_erase
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secure_erase"></a> [secure\_erase](#module\_secure\_erase) | ../../modules/redfish_idrac_secure_erase | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_racks"></a> [racks](#input\_racks) | Map of iDRAC hostname/IP to credentials and controller names on which secure erase would be run. | <pre>map(object({<br>    username     = string<br>    password     = string<br>    ssl_verify   = bool<br>    controller_names = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_physical_disk_fqdds"></a> [physical\_disk\_fqdds](#output\_physical\_disk\_fqdds) | Map of iDRAC hostname to list of physical disk FQDDs on which secure erase would be run on destroy. |
<!-- END_TF_DOCS -->