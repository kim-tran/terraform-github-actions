resource "azurerm_storage_queue" "this" {
  for_each             = var.queues
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.this.name
  metadata             = each.value.metadata

  # dynamic "timeouts" {
  #   for_each = var.storage_queue_timeouts == null ? [] : [var.storage_queue_timeouts]

  #   content {
  #     create = timeouts.value.create
  #     delete = timeouts.value.delete
  #     read   = timeouts.value.read
  #     update = timeouts.value.update
  #   }
  # }
  # depends_on = [azurerm_storage_account.this]
}