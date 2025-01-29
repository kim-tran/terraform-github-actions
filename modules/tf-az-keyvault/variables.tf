variable "purpose_abbreviation" {
  description = "What is the abbreviated purpose for this key vault? (lowercase letters, numbers and hyphens, 14 character limit)"
  default     = "data"

  # We have the limit set to 15 because the limitations for a KV name are 3-24 chars
  # we burn 6 to add the kv-sh- prefix
  # we burn 4 more to add the env suffix
  # that only leaves 14 for this field
  validation {
    condition     = length(var.purpose_abbreviation) <= 14 && can(regex("^[a-z0-9][a-z0-9-]+[a-z0-9]$", var.purpose_abbreviation))
    error_message = "Purpose abbreviation must be 14 characters or less, and only contain lowercase letters, numbers, or hyphens."
  }
}

variable "secrets_user_identities" {
  type        = list(string)
  description = "principal_ids for managed identities which should be able to access secrets in this Key Vault. These identities will be granted the 'Key Vault Secrets User' role."
  default     = []
}

variable "secret_officer_ad_groups" {
  type        = set(string)
  description = "security-enabled AD groups who will be allowed to maintain and access secrets in this Key Vault"
  default     = []
}

variable "location" {
  type        = string
  description = "The Azure region in which to create these resources."

}

variable "environment_key" {
  type        = string
  description = "The environment key for this Key Vault."
}

variable "unique_identifier" {
  type        = string
  description = "Unique identifier to differentiate key vaults"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet in which to deploy the Private Endpoint for this Key Vault."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to deploy this Key Vault."

}

variable "tenant_id" {
  type        = string
  description = "The tenant ID for this Key Vault."
  default     = "16b3c013-d300-468d-ac64-7eda0820b6d3"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources. This should be provided by the tagging module."
}

variable "kubernetes_service_account" {
  type = object({
    name                = string
    namespace           = string
    aks_oidc_issuer_url = string
    azure_role          = optional(string)
    azure_roles         = optional(set(string))
  })
  default     = null
  description = "Kubernetes service account which should be granted access to this Key Vault"
}

variable "github_repository" {
  type = object({
    org                  = optional(string)
    name                 = string
    azure_role           = string
    pull_request_enabled = optional(bool)
    branches             = optional(set(string))
    environments         = optional(set(string))
  })
  default     = null
  description = "GitHub Repository which should be granted access this Key Vault"
}

locals {
  create_kubernetes_managed_id = var.kubernetes_service_account != null
  create_github_managed_id     = var.github_repository != null

  kubernetes_service_account_role_assignments = var.kubernetes_service_account == null ? toset([]) : toset(compact(setunion(
    lookup(var.kubernetes_service_account, "azure_roles", []),
    [lookup(var.kubernetes_service_account, "azure_role", null)]
  )))
}
