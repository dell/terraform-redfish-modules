
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

locals {

    server_local_users = [
        for pair in setproduct(var.idracs, var.idrac_local_users) : {
            redfish_server = {
                endpoint = pair[0].endpoint
                user = pair[0].user
                password = pair[0].password
                ssl_insecure = pair[0].ssl_insecure
            }
            user_id = pair[1].user_id
            username = pair[1].name
            password = pair[1].password
            role_id = pair[1].role_id
            enabled = pair[1].enabled
        }
    ]
}

resource "redfish_user_account" "idrac_local_users" {
    # local.server_local_users is a list, so project it into a map
    # where each key is unique. Use endpoint with username as the unique key per instance.
    
    for_each = {
        for idrac in local.server_local_users : "${idrac.redfish_server.endpoint}/AccountService/Accounts/${idrac.username}" => idrac
    }

    redfish_server {
        endpoint = each.value.redfish_server.endpoint
        user =  each.value.redfish_server.user
        password = each.value.redfish_server.password
        ssl_insecure = each.value.redfish_server.ssl_insecure
    }
    user_id = each.value.user_id
    username = each.value.username
    password = each.value.password
    role_id = each.value.role_id
    enabled = each.value.enabled
}

