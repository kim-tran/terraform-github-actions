# variable "storage_table_name" {
#   type        = string
#   description = "(Required) The name of the storage table. Only Alphanumeric characters allowed, starting with a letter. Must be unique within the storage account the table is located. Changing this forces a new resource to be created."
#   nullable    = false
# }

# variable "storage_table_storage_account_name" {
#   type        = string
#   description = "(Required) Specifies the storage account in which to create the storage table. Changing this forces a new resource to be created."
#   nullable    = false
# }

# variable "storage_table_acl" {
#   type = set(object({
#     id = string
#     access_policy = optional(list(object({
#       expiry      = string
#       permissions = string
#       start       = string
#     })))
#   }))
#   default     = null
#   description = <<-EOT
#  - `id` - (Required) The ID which should be used for this Shared Identifier.

#  ---
#  `access_policy` block supports the following:
#  - `expiry` - (Required) The ISO8061 UTC time at which this Access Policy should be valid until.
#  - `permissions` - (Required) The permissions which should associated with this Shared Identifier.
#  - `start` - (Required) The ISO8061 UTC time at which this Access Policy should be valid from.
# EOT
# }

# variable "storage_table_timeouts" {
#   type = object({
#     create = optional(string)
#     delete = optional(string)
#     read   = optional(string)
#     update = optional(string)
#   })
#   default     = null
#   description = <<-EOT
#  - `create` - (Defaults to 30 minutes) Used when creating the Storage Table.
#  - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Table.
#  - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Table.
#  - `update` - (Defaults to 30 minutes) Used when updating the Storage Table.
# EOT
# }

variable "tables" {
  type = map(object({
    name = string
    acl = optional(set(object({
      id = string
      access_policy = optional(list(object({
        expiry      = string
        permissions = string
        start       = string
      })))
    })))
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
