
locals {
  landing_zones = {
    for landing_zone in fileset("C:/Users/kitra/Documents/GitHub/terraform-github-actions/landing-zones/${var.landing_zones_folder}/", "*.json") :
    trimsuffix(landing_zone, ".json") => jsondecode(file("C:/Users/kitra/Documents/GitHub/terraform-github-actions/landing-zones/${var.landing_zones_folder}/${landing_zone}"))
  }

  # hub_network_resource_id = ""
  nodes = merge([
    for k, v in local.landing_zones : {
      for region, network in try(v.virtual_networks, {}) : "${k}_${region}" => {
        landing_zone           = k
        region                 = region
        location               = v.locations
        link_private_dns_zones = try(v.link_private_dns_zones, true)
        virtual_networks       = v.virtual_networks
      }
    }
  ]...)
}

output "landing_zones" {
  value = local.landing_zones
}
