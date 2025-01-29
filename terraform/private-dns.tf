# provider "azurerm" {
#   alias = "connectivity"
#   features {}
#   subscription_id = module.landing_zones["platform_connectivity_prod"].subscription_id
# }

# locals {
#   dns_zone_vnet_links = merge([
#     for dns_zone in var.private_dns_zones : {
#       for node_key, node_value in local.nodes : "${node_key}_${dns_zone}" => {
#         name                  = "link-${node_key}-${dns_zone}"
#         private_dns_zone_name = dns_zone
#         resource_group_name   = try(azurerm_resource_group.zones[0].name, "")
#         virtual_network_key   = node_key
#         virtual_network_id    = module.landing_zones[node_value.landing_zone].virtual_network_resource_ids[node_value.region]
#       } if node_value.link_private_dns_zones != false
#     }
#   ]...)
# }

# resource "azurerm_resource_group" "zones" {
#   provider = azurerm.connectivity
#   count    = var.deploy_private_dns_zones ? 1 : 0

#   name     = "${module.naming["platform_connectivity_prod_primary"].resource_group.name}-private-dns-001"
#   location = local.landing_zones["platform_connectivity_prod"].locations["primary"]
# }

# resource "azurerm_private_dns_zone" "this" {
#   provider            = azurerm.connectivity
#   for_each            = var.deploy_private_dns_zones ? toset(var.private_dns_zones) : []
#   name                = each.value
#   resource_group_name = azurerm_resource_group.zones[0].name
#   tags                = {}
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "this" {
#   depends_on = [
#     azurerm_private_dns_zone.this,
#     module.landing_zones
#   ]
#   for_each = var.deploy_private_dns_zones ? local.dns_zone_vnet_links : {}
#   provider = azurerm.connectivity

#   name                  = trimsuffix(substr(each.value.name, 0, 80), ".")
#   private_dns_zone_name = each.value.private_dns_zone_name
#   resource_group_name   = each.value.resource_group_name
#   virtual_network_id    = each.value.virtual_network_id
# }