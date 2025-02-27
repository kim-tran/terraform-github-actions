# # The PE resource when we are managing the private_dns_zone_group block:
# resource "azurerm_private_endpoint" "this" {
#   for_each = { for k, v in var.private_endpoints : k => v if var.private_endpoints_manage_dns_zone_group }

#   location                      = each.value.location != null ? each.value.location : var.location
#   name                          = each.value.name != null ? each.value.name : "pe-${var.name}"
#   resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
#   subnet_id                     = each.value.subnet_resource_id
#   custom_network_interface_name = each.value.network_interface_name
#   tags                          = each.value.tags

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "pse-${var.name}"
#     private_connection_resource_id = azurerm_storage_account.this.id
#     subresource_names              = [each.value.subresource_name]
#   }

#   dynamic "ip_configuration" {
#     for_each = each.value.ip_configurations

#     content {
#       name               = ip_configuration.value.name
#       private_ip_address = ip_configuration.value.private_ip_address
#       member_name        = each.value.subresource_name
#       subresource_name   = each.value.subresource_name
#     }
#   }

#   dynamic "private_dns_zone_group" {
#     for_each = length(each.value.private_dns_zone_resource_ids) > 0 ? ["this"] : []

#     content {
#       name                 = each.value.private_dns_zone_group_name
#       private_dns_zone_ids = each.value.private_dns_zone_resource_ids
#     }
#   }
# }

# # The PE resource when we are managing **not** the private_dns_zone_group block:
# resource "azurerm_private_endpoint" "this_unmanaged_dns_zone_groups" {
#   for_each = { for k, v in var.private_endpoints : k => v if !var.private_endpoints_manage_dns_zone_group }

#   location                      = each.value.location != null ? each.value.location : var.location
#   name                          = each.value.name != null ? each.value.name : "pe-${var.name}"
#   resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
#   subnet_id                     = each.value.subnet_resource_id
#   custom_network_interface_name = each.value.network_interface_name
#   tags                          = each.value.tags

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "pse-${var.name}"
#     private_connection_resource_id = azurerm_storage_account.this.id
#     subresource_names              = [each.value.subresource_name]
#   }

#   dynamic "ip_configuration" {
#     for_each = each.value.ip_configurations

#     content {
#       name               = ip_configuration.value.name
#       private_ip_address = ip_configuration.value.private_ip_address
#       member_name        = each.value.subresource_name
#       subresource_name   = each.value.subresource_name
#     }
#   }

#   lifecycle {
#     ignore_changes = [private_dns_zone_group]
#   }
# }

resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoints

  location                      = each.value.location
  name                          = each.value.name != null ? each.value.name : "pe-${var.name}"
  resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
  subnet_id                     = each.value.subnet_resource_id
  custom_network_interface_name = each.value.network_interface_name
  tags                          = each.value.inherit_tags ? merge(each.value.tags, var.tags) : each.value.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "pse-${var.name}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = each.value.subresource_name
  }
  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      member_name        = each.value.subresource_name
      subresource_name   = each.value.subresource_name
    }
  }
  dynamic "private_dns_zone_group" {
    for_each = length(each.value.private_dns_zone_resource_ids) > 0 ? ["this"] : []

    content {
      name                 = each.value.private_dns_zone_group_name
      private_dns_zone_ids = each.value.private_dns_zone_resource_ids
    }
  }
}
