output "id" {
  value       = azurerm_key_vault.keyvault.id
  description = "Key Vault id"

  depends_on = [time_sleep.wait_for_dns_propagation]
}

output "name" {
  value       = azurerm_key_vault.keyvault.name
  description = "Key Vault name"
}

output "uri" {
  value       = azurerm_key_vault.keyvault.vault_uri
  description = "Key Vault uri"

  depends_on = [time_sleep.wait_for_dns_propagation]
}
