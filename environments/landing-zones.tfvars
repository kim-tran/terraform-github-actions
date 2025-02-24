
partner_cuid = "00000000-0000-0000-0000-000000000000"
owners = [
  #"00000000-0000-0000-0000-000000000000",
  #"00000000-0000-0000-0000-000000000000",
]

landing_zones_folder       = "prd"
subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/00000000-0000-0000-0000-000000000000:00000000-0000-0000-0000-000000000000_0000-00-00/billingProfiles/0000-0000-000-000/invoiceSections/0000-0000-000-000"
deploy_ddos_protection     = true
deploy_private_dns_zones   = true

private_dns_zones = [
  "privatelink.blob.core.windows.net",
  "privatelink.dfs.core.windows.net",
  "privatelink.file.core.windows.net",
  "privatelink.queue.core.windows.net",
]
