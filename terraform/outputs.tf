# output "landing_zones" {
#   value = { for landing_zone, output in module.landing_zones : landing_zone => {
#     subscription_id                              = output.subscription_id
#     subscription_resource_id                     = output.subscription_resource_id
#     management_group_subscription_association_id = output.management_group_subscription_association_id
#     umi_client_id                                = try(output.umi_client_id, null)
#     umi_id                                       = try(output.umi_id, null)
#     umi_principal_id                             = try(output.umi_principal_id, null)
#     umi_tenant_id                                = try(output.umi_tenant_id, null)
#     virtual_networks = {
#       for k, v in output.virtual_network_resource_ids : k => {
#         id                              = v
#         resource_group_name             = split("/", v)[4]
#         virtual_network_name            = split("/", v)[8]
#         address_space                   = local.landing_zones[landing_zone].virtual_networks[k].address_space
#         # ddos_protection_enabled         = try(v.ddos_protection_enabled, null)
#         # ddos_protection_plan_id         = try(v.ddos_protection_plan_id, null)
#         hub_peering_enabled             = try(v.hub_peering_enabled, null)
#         hub_peering_use_remote_gateways = try(v.hub_peering_use_remote_gateways, null)
#         hub_network_resource_id         = try(v.hub_network_resource_id, null)
#       }
#     }
#   } }
# }
