resource "azurerm_key_vault" "keyvault" {
  name                          = "kv-${var.purpose_abbreviation}-${var.environment_key}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = true
  tenant_id                     = var.tenant_id
  soft_delete_retention_days    = 90
  purge_protection_enabled      = true
  enable_rbac_authorization     = true
  sku_name                      = "standard"
  public_network_access_enabled = false

  tags = var.tags
}

# Deploy the Private Endpoint
resource "azurerm_private_endpoint" "keyvault" {
  name                          = "pep-${azurerm_key_vault.keyvault.name}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-${azurerm_key_vault.keyvault.name}"

  private_service_connection {
    name                           = "psc-${azurerm_key_vault.keyvault.name}"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "time_sleep" "wait_for_dns_propagation" {
  create_duration = "2m"
  depends_on      = [azurerm_private_endpoint.keyvault]
}
