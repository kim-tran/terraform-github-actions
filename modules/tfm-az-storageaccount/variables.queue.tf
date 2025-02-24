# variable "storage_queue_name" {
#   type        = string
#   description = "(Required) The name of the Queue which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created."
#   nullable    = false
# }

# variable "storage_queue_storage_account_name" {
#   type        = string
#   description = "(Required) Specifies the Storage Account in which the Storage Queue should exist. Changing this forces a new resource to be created."
#   nullable    = false
# }

# variable "storage_queue_metadata" {
#   type        = map(string)
#   default     = null
#   description = "(Optional) A mapping of MetaData which should be assigned to this Storage Queue."
# }

# variable "storage_queue_timeouts" {
#   type = object({
#     create = optional(string)
#     delete = optional(string)
#     read   = optional(string)
#     update = optional(string)
#   })
#   default     = null
#   description = <<-EOT
#  - `create` - (Defaults to 30 minutes) Used when creating the Storage Queue.
#  - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Queue.
#  - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Queue.
#  - `update` - (Defaults to 30 minutes) Used when updating the Storage Queue.
# EOT
# }


variable "queues" {
  type = map(object({
    metadata = optional(map(string))
    name     = string
    # role_assignments = optional(map(object({
    #   role_definition_id_or_name             = string
    #   principal_id                           = string
    #   description                            = optional(string, null)
    #   skip_service_principal_aad_check       = optional(bool, false)
    #   condition                              = optional(string, null)
    #   condition_version                      = optional(string, null)
    #   delegated_managed_identity_resource_id = optional(string, null)
    # })), {})
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default     = {}
  description = <<-EOT
 - `metadata` - (Optional) A mapping of MetaData which should be assigned to this Storage Queue.
 - `name` - (Required) The name of the Queue which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created.

Supply role assignments in the same way as for `var.role_assignments`.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Queue.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Queue.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Queue.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Queue.
EOT
  nullable    = false
}