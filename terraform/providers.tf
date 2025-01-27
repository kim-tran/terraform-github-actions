terraform {
  backend "azurerm" {
    use_azuread_auth = true
    use_oidc         = true
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}
