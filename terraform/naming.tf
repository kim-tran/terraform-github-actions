locals {
  names = merge([
    for k, v in flatten(concat([
      for k, v in local.landing_zones : {
        for region, location in v.locations : "${k}_${region}" => {
          location    = location
          landingzone = v.landingzone
          environment = v.environment
  } }])) : { for x, y in v : x => y }]...)
}

module "naming" {
  source = "../modules/tf-az-naming"

  for_each = local.names

  label_order = [
    "namespace",   # project name
    "stage",       # subscription type
    "name",        # app name
    "attributes",  # [OPTIONAL] app attributes
    "environment", # location
  ]

  namespace   = each.value.landingzone #project name
  stage       = each.value.environment #subscription type
  name        = "kitra"                #app name
  environment = each.value.location

  tags = {
    "BusinessUnit" = "MCAPS"
  }
}

output "naming" {
  value = module.naming
}