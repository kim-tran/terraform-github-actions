locals {
  regions = local.landing_zones["platform_management_prod"].locations
  context = module.naming["platform_management_prod_primary"].context
}



module "naming_platform_management_prod" {
  source = "../modules/tf-az-naming"

  for_each = local.regions
  context  = local.context

}

output "regions" {
  value = local.regions
}

output "naming_platform_management_prod" {
  value = module.naming_platform_management_prod
}

data "azurerm_resource_group" "rg_management_prod_kitra_westus2" {
  name = "rg-management-prod-kitra-westus2-infra-001"
}

resource "azurerm_log_analytics_workspace" "log_analytics_westus2" {
  name                = "${module.naming_platform_management_prod["primary"].id_resource.log_analytics_workspace}-001"
  location            = module.naming_platform_management_prod["primary"].environment
  resource_group_name = data.azurerm_resource_group.rg_management_prod_kitra_westus2.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}