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

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.6.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.4.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  storage_use_azuread = true
  subscription_id     = "b2c5ab64-1473-483f-a839-ef88914ac0b8"

  partner_id = var.partner_cuid != "" ? var.partner_cuid : null
}

provider "azapi" {
  use_oidc   = true
  partner_id = var.partner_cuid != "" ? var.partner_cuid : null
}


