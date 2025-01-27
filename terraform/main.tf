locals {
  primary_region = "eastus"
}

data "azurerm_resource_group" "rg" {
  name = "rg"
}

# Virtual Network
resource "azurerm_virtual_network" "virtual_network" {
  name                = "vnet-networking-eus-dev-01"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Subnet 1
resource "azurerm_subnet" "subnet_pep" {
  name                 = "snet-pep-eus-dev-01"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

module "key_vault" {
  source = "../modules/tf-az-keyvault"

  location            = locals.primary_region
  subnet_id           = azurerm_subnet.subnet_pep.id
  resource_group_name = data.azurerm_resource_group.rg.name
  environment_key     = "dev"
  tags = {
    "IaC" = "Terraform"
  }
}

