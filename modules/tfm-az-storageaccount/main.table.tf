
resource "azurerm_storage_table" "this" {
  for_each             = var.tables
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.this.name

  dynamic "acl" {
    for_each = each.value.acl == null ? [] : each.value.acl

    content {
      id = acl.value.id

      dynamic "access_policy" {
        for_each = acl.value.access_policy == null ? [] : acl.value.access_policy

        content {
          expiry      = access_policy.value.expiry
          permissions = access_policy.value.permissions
          start       = access_policy.value.start
        }
      }
    }
  }
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

