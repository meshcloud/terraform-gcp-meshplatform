variable "sa_name" {
  type        = string
  description = "name of the service account to create"
}

variable "org_id" {
  type        = string
  description = "GCP Organization Id"
}

variable "project_id" {
  type        = string
  description = "GCP Project ID where to create the resources. This is typically a 'meshstack-root' project"
}

variable "landing_zone_folder_ids" {
  type        = set(string)
  description = "GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders."
}

variable "billing_org_id" {
  type        = string
  description = "GCP Organization Id that holds billing account"
}

variable "billing_account_id" {
  type        = string
  description = "The GCP Billing Account in your organization."
}
