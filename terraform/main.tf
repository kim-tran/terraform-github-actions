locals {
  primary_region   = "eastus"
  secondary_region = "westus"
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

  location            = local.primary_region
  subnet_id           = azurerm_subnet.subnet_pep.id
  resource_group_name = data.azurerm_resource_group.rg.name
  environment_key     = "dev"
  unique_identifier   = "kitra"
  tags = {
    "IaC" = "Terraform"
  }
}


module "naming_kitra_dev_label" {
  source = "../modules/tf-az-naming"

  delimiter = "-"
  namespace = "kitra"
  stage     = "dev"

  tags = {
    "BusinessUnit" = "MCAPS",
    "NamingLabel"  = "true"
  }
}

module "naming_eastus_label" {
  source = "../modules/tf-az-naming"

  environment = "eastus"

  # Copy all other fields from the base label
  context = module.naming_kitra_dev_label
}

module "naming_westus_label" {
  source = "../modules/tf-az-naming"

  environment = "westus"

  # Copy all other fields from the base label
  context = module.naming_kitra_dev_label
}


resource "azurerm_resource_group" "eastus" {
  name     = module.naming_eastus_label.resource_group
  location = local.primary_region
}

resource "azurerm_resource_group" "westus" {
  name     = module.naming_westus_label.resource_group
  location = local.secondary_region
}


