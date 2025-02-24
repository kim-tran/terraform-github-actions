variable "location" {
  type        = string
  description = <<DESCRIPTION
Azure region where the resource should be deployed.
If null, the location will be inferred from the resource group location.
DESCRIPTION
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the resource."

  # validation {
  #   condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
  #   error_message = "The name must be between 3 and 24 characters, valid characters are lowercase letters and numbers."
  # }
}

# This is required for most resource modules
variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Custom tags to apply to the resource."
}

# variable "managed_identities" {
#   type = object({
#     system_assigned            = optional(bool, false)
#     user_assigned_resource_ids = optional(set(string), [])
#   })
#   default     = {}
#   description = <<DESCRIPTION
#   Controls the Managed Identity configuration on this resource. The following properties can be specified:

#   - `system_assigned` - (Optional) Specifies if the System Assigned Managed Identity should be enabled.
#   - `user_assigned_resource_ids` - (Optional) Specifies a list of User Assigned Managed Identity resource IDs to be assigned to this resource.
#   DESCRIPTION
#   nullable    = false
# }

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of role assignments to create on the resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
DESCRIPTION
  nullable    = false
}