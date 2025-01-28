module "app_label" {
  source = "../modules/tf-az-naming"

  label_order = [
    "namespace",   # project name
    "stage",       # subsciption type
    "name",        # app name
    "attributes",   # app attributes
    "environment", # location
  ]

  for_each    = local.regions
  environment = each.value                #location
  namespace   = "kitra"                   #project name
  stage       = "dev"                     #subscription type
  name        = "app"                     #app name

  tags = {
    "BusinessUnit" = "MCAPS"
  }
}