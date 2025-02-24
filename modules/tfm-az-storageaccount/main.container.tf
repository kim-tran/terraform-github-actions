
resource "azurerm_storage_container" "this" {
  for_each                          = var.containers
  name                              = each.value.name
  storage_account_id                = azurerm_storage_account.this.id
  container_access_type             = each.value.container_access_type
  default_encryption_scope          = each.value.default_encryption_scope
  encryption_scope_override_enabled = each.value.encryption_scope_override_enabled
  metadata                          = each.value.metadata

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
  # depends_on = [azurerm_storage_account.this]
}