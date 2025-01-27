resource "azurerm_role_assignment" "secret_user" {
  count                = length(var.secrets_user_identities)
  principal_id         = var.secrets_user_identities[count.index]
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.keyvault.id
}

data "azuread_group" "secret_officer" {
  for_each         = var.secret_officer_ad_groups
  display_name     = each.value
  security_enabled = true
}

resource "azurerm_role_assignment" "secret_officer" {
  for_each             = var.secret_officer_ad_groups
  principal_id         = data.azuread_group.secret_officer[each.key].object_id
  role_definition_name = "Key Vault Secrets Officer" # https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#key-vault-secrets-officer
  scope                = azurerm_key_vault.keyvault.id
}

resource "azurerm_role_assignment" "certificates_officer" {
  for_each             = var.secret_officer_ad_groups
  principal_id         = data.azuread_group.secret_officer[each.key].object_id
  role_definition_name = "Key Vault Certificates Officer"
  scope                = azurerm_key_vault.keyvault.id
}
