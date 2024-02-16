/*
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
*/

module "secure_erase" {
    for_each = var.racks
    source = "../../modules/redfish_idrac_secure_erase"

    hostname = each.key
    username = each.value.username
    password = each.value.password
    ssl_verify = each.value.ssl_verify

    controller_names = each.value.controller_names
}
