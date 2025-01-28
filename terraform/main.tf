locals {

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

# module "key_vault" {
#   source = "../modules/tf-az-keyvault"

#   location            = local.primary_001
#   subnet_id           = azurerm_subnet.subnet_pep.id
#   resource_group_name = data.azurerm_resource_group.rg.name
#   environment_key     = "dev"
#   unique_identifier   = "kitra"
#   tags = {
#     "IaC" = "Terraform"
#   }
# }

resource "azurerm_resource_group" "rg_app" {
  for_each = local.regions
  location = module.app_label[each.key].environment
  name     = module.app_label[each.key].id_resource.resource_group
}
resource "azurerm_log_analytics_workspace" "log_analytics_dev_westus" {
  name                = module.app_label["secondary_001"].id_resource.log_analytics_workspace
  location            = local.regions["secondary_001"]
  resource_group_name = azurerm_resource_group.rg_app["primary_001"].name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}