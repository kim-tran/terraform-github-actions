variable "containers" {
  type = map(object({
    name                              = string
    storage_account_id                = optional(string)
    container_access_type             = optional(string)
    default_encryption_scope          = optional(string)
    encryption_scope_override_enabled = optional(bool)
    metadata                          = optional(map(string))
    # role_assignment                   = optional(object({
    #   principal_id         = string
    #   role_definition_name = string
    # }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default = {}
  # description = <<-EOT
  # - `name` - (Required) The name of the Container which should be created within the Storage Account. Changing this forces a new resource to be created.
  # - `storage_account_id` - (Optional) The name of the Storage Account where the Container should be created. Changing this forces a new resource to be created.
  # - `container_access_type` - (Optional) The Access Level configured for this Container. Possible values are `blob`, `container` or `private`. Defaults to `private`.
  # - `default_encryption_scope` - (Optional) The default encryption scope to use for blobs uploaded to this container. Changing this forces a new resource to be created.
  # - `encryption_scope_override_enabled` - (Optional) Whether to allow blobs to override the default encryption scope for this container. Can only be set when specifying `default_encryption_scope`. Defaults to `true`. Changing this forces a new resource to be created.
  # - `metadata` - (Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase.
  # - `timeouts` - (Optional) A mapping of timeouts for the Storage Container.
  # EOT
  # description = "(Required) A map of storage containers to be created with their configurations."
}


