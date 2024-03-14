variable "sa_name" {
  type        = string
  description = "Name of the service account to create."
}

variable "org_id" {
  type        = string
  description = "GCP Organization ID that holds the projects that generate billing data that the service account should import."
}

variable "meshstack_root_project_id" {
  type        = string
  description = "GCP Project ID where to create the service account. This is typically a 'meshstack-root' project."
}

variable "cloud_billing_export_project_id" {
  type        = string
  description = "GCP Project where the BigQuery table resides that holds the Cloud Billing export to BigQuery."
}

variable "cloud_billing_export_dataset_id" {
  type        = string
  description = "GCP BigQuery dataset containing the Cloud Billing BigQuery export."
}

variable "landing_zone_folder_ids" {
  type        = set(string)
  description = "GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders."
}

variable "service_account_key" {
  default = true
  type    = bool
}

variable "workload_identity_federation" {
  type = object({
    pool_id = string
    subject = string
  })
}
