# variable "private_endpoints" {
#   type = map(object({
#     name = optional(string, null)
#     role_assignments = optional(map(object({
#       role_definition_id_or_name             = string
#       principal_id                           = string
#       description                            = optional(string, null)
#       skip_service_principal_aad_check       = optional(bool, false)
#       condition                              = optional(string, null)
#       condition_version                      = optional(string, null)
#       delegated_managed_identity_resource_id = optional(string, null)
#       principal_type                         = optional(string, null)
#     })), {})
#     lock = optional(object({
#       kind = string
#       name = optional(string, null)
#     }), null)
#     tags                                    = optional(map(string), null)
#     subnet_resource_id                      = string
#     subresource_name                        = string
#     private_dns_zone_group_name             = optional(string, "default")
#     private_dns_zone_resource_ids           = optional(set(string), [])
#     application_security_group_associations = optional(map(string), {})
#     private_service_connection_name         = optional(string, null)
#     network_interface_name                  = optional(string, null)
#     location                                = optional(string, null)
#     resource_group_name                     = optional(string, null)
#     ip_configurations = optional(map(object({
#       name               = string
#       private_ip_address = string
#     })), {})
#   }))
#   default     = {}
#   description = <<DESCRIPTION
# A map of private endpoints to create on the resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

# - `name` - (Optional) The name of the private endpoint. One will be generated if not set.
# - `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
# - `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
# - `tags` - (Optional) A mapping of tags to assign to the private endpoint.
# - `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
# - `subresource_name` - The service name of the private endpoint.  Possible value are `blob`, 'dfs', 'file', `queue`, `table`, and `web`.
# - `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
# - `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
# - `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
# - `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
# - `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
# - `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
# - `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of the resource.
# - `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
#   - `name` - The name of the IP configuration.
#   - `private_ip_address` - The private IP address of the IP configuration.
# DESCRIPTION
#   nullable    = false
# }

# variable "private_endpoints_manage_dns_zone_group" {
#   type        = bool
#   default     = true
#   description = "Whether to manage private DNS zone groups with this module. If set to false, you must manage private DNS zone groups externally, e.g. using Azure Policy."
#   nullable    = false
# }

variable "private_endpoints" {
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
    lock = optional(object({
      name = optional(string, null)
      kind = optional(string, null)
    }), {})
    tags                                    = optional(map(any), null)
    subnet_resource_id                      = string
    subresource_name                        = list(string)
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    inherit_tags                            = optional(bool, false)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
  default     = {}
  description = <<DESCRIPTION
A map of private endpoints to create on the resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the private endpoint. One will be generated if not set.
- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
- `tags` - (Optional) A mapping of tags to assign to the private endpoint.
- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
- `subresource_name` - The service name of the private endpoint.  Possible value are `blob`, 'dfs', 'file', `queue`, `table`, and `web`.
- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of the resource.
- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `name` - The name of the IP configuration.
  - `private_ip_address` - The private IP address of the IP configuration.
DESCRIPTION
}