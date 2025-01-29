module "landing_zones" {
  source  = "Azure/lz-vending/azurerm"
  version = "4.1.5"

  for_each = local.landing_zones
  location = each.value.locations["primary"]

  # subscription variables
  subscription_display_name    = each.value.name
  subscription_alias_enabled   = try(each.value.subscription_alias_enabled, false)
  subscription_update_existing = try(each.value.subscription_update_existing, false)
  subscription_id              = try(each.value.subscription_id, null)
  subscription_alias_name      = try(each.value.subscription_alias_enabled, false) ? each.value.name : null
  subscription_billing_scope   = try(each.value.subscription_alias_enabled, false) ? var.subscription_billing_scope : null
  subscription_workload        = try(each.value.subscription_workload, "Production")

  # management group association variables
  subscription_management_group_association_enabled = try(each.value.subscription_management_group_id, {}) != {}
  subscription_management_group_id                  = try(each.value.subscription_management_group_id, null)

  # virtual network variables
  virtual_network_enabled = try(each.value.virtual_networks, {}) != {}
  virtual_networks = { for k, v in try(each.value.virtual_networks, {}) : k => {
    name                        = "${module.naming["${each.key}_${split("_", k)[0]}"].id_resource.virtual_network}-${try(split("_", k)[1])}"
    resource_group_name         = "${module.naming["${each.key}_${split("_", k)[0]}"].id_resource.resource_group}-infra-${try(split("_", k)[1])}"
    address_space               = v.address_space
    resource_group_lock_enabled = try(v.resource_group_lock_enabled, false)

    # # ddos protection plan
    # ddos_protection_enabled = try(v.ddos_protection_enabled, false)
    # ddos_protection_plan_id = azurerm_network_ddos_protection_plan.this[0].id

    hub_peering_enabled             = try(v.hub_peering_enabled, false)
    hub_peering_use_remote_gateways = try(v.hub_peering_enabled, false) ? try(v.hub_peering_use_remote_gateways, true) : false
    # hub_network_resource_id         = try(v.hub_peering_enabled, false) ? local.hub_network_resource_id : null
    }
  }
  network_watcher_resource_group_enabled = try(each.value.network_watcher_resource_group_enabled, true)

  # resource groups
  resource_group_creation_enabled = try(each.value.resource_groups, {}) != {}
  resource_groups = { for k, v in try(each.value.resource_groups, {}) : k => {
    name                = "${module.naming["${each.key}_${v.region}"].id_resource.resource_group}-${split("_", k)[0]}-${try(split("_", k)[1])}"
    location            = each.value.locations[v.region]
    tags                = try(v.tags, {})
    resource_locks      = try(v.resource_locks, {})
    resource_group_lock = try(v.resource_group_lock, {})
    }
  }

  # role assignments
  role_assignment_enabled = try(each.value.role_assignments, {}) != {}
  role_assignments        = try(each.value.role_assignments, {})

  disable_telemetry = true
}
