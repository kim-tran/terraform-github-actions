terraform {
  backend "azurerm" {
    use_azuread_auth = true
    use_oidc         = true

    resource_group_name  = "rg-terraform-ops"
    storage_account_name = "casadevopstf"
    container_name       = "ops-terraform-state"
    key                  = "pipeline-test.dev.tfstate"
    client_id            = "15370b20-b6e8-4639-afb3-e09cf769b8d8"
    subscription_id      = "b2c5ab64-1473-483f-a839-ef88914ac0b8"
    tenant_id            = "16b3c013-d300-468d-ac64-7eda0820b6d3"
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
  subscription_id     = "b2c5ab64-1473-483f-a839-ef88914ac0b8"
}


