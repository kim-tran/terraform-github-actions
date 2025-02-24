locals {
  regions = local.landing_zones["platform_management_prod"].locations
  context = module.naming["platform_management_prod_primary"].context
}



# module "naming_mgmt_prd" {
#   source = "../modules/tf-az-naming"

#   for_each = local.regions
#   context  = local.context

# }

# output "regions" {
#   value = local.regions
# }

# data "azurerm_resource_group" "mgmt_prod_wus2" {
#   name = "rg-mgmt-prd-wus2-infra-001"
# }


# resource "azurerm_log_analytics_workspace" "log_analytics_westus2" {
#   name                = "${module.naming_mgmt_prd["primary"].id_resource.log_analytics_workspace}-001"
#   location            = local.regions["primary"]
#   resource_group_name = data.azurerm_resource_group.mgmt_prod_wus2.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }


# module "storage_account" {
#   source              = "../modules/tfm-az-storageaccount"
#   name                = module.naming_mgmt_prd["primary"].id_for_storage_account
#   location            = local.regions["primary"]
#   resource_group_name = data.azurerm_resource_group.mgmt_prod_wus2.name
#   containers = {
#     "container_001" = {
#       name = "container-001"
#     },
#     "container_002" = {
#       name = "container-002"
#     }
#   }
# }

# data "azurerm_virtual_network" "this" {
#   name                = "vnet-mgmt-prd-wus2-001"
#   resource_group_name = data.azurerm_resource_group.mgmt_prod_wus2.name
# }

# resource "azurerm_subnet" "this" {
#   count = 2

#   address_prefixes     = ["10.0.${count.index}.0/24"]
#   name                 = format("%s%d", module.naming_mgmt_prd["primary"].id_resource.subnet, count.index)
#   resource_group_name  = data.azurerm_resource_group.mgmt_prod_wus2.name
#   virtual_network_name = data.azurerm_virtual_network.this.name
# }

# module "route_table" {
#   source              = "C:/Users/kitra/Documents/GitHub/IH/modules/tfm-az-routetable"
#   name                = "${module.naming_mgmt_prd["primary"].id_resource.route_table}-001"
#   resource_group_name = data.azurerm_resource_group.mgmt_prod_wus2.name
#   location            = local.regions["primary"]

#   routes = {
#     test-route-vnetlocal = {
#       name           = "route-vnetlocal-wus2-001"
#       address_prefix = "10.2.0.0/32"
#       next_hop_type  = "VnetLocal"
#     },
#     test-route-nva = {
#       name                   = "route-nva-wus2-001"
#       address_prefix         = "10.1.0.0/24"
#       next_hop_type          = "VirtualAppliance"
#       next_hop_in_ip_address = "10.0.0.1"
#     },
#     test-route-vnetlocal2 = {
#       name           = "route-vnetlocal2-wus2-001"
#       address_prefix = "10.1.0.0/16"
#       next_hop_type  = "VnetLocal"
#     },
#     test-route-vnetgateway = {
#       name           = "route-vnetgateway-wus2-001"
#       address_prefix = "10.0.0.0/8"
#       next_hop_type  = "VirtualNetworkGateway"
#     },
#     test-route-internet = {
#       name           = "route-internet-wus2-001"
#       address_prefix = "0.0.0.0/0"
#       next_hop_type  = "Internet"
#     }
#   }

#   subnet_resource_ids = {
#     subnet1 = azurerm_subnet.this[0].id,
#     subnet2 = azurerm_subnet.this[1].id
#   }

# }

# output "routes" {
#   value = module.route_table.routes
# }