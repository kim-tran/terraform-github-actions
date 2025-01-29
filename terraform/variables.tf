variable "landing_zones_folder" {
  type    = string
  default = "production"
}

variable "subscription_billing_scope" {
  type    = string
  default = "/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}"
}

variable "owners" {
  type    = list(string)
  default = []
}

# variable "deploy_ddos_protection" {
#   type    = bool
#   default = false
# }

variable "deploy_private_dns_zones" {
  type    = bool
  default = false
}