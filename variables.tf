variable "project_id" {
  type        = string
  description = "GCP Project ID where to create the resources. This is typically a 'meshstack-root' project."
}

variable "org_id" {
  type        = string
  description = "GCP Organization ID that holds the projects that generate billing data that the service account should import."
}

variable "billing_org_id" {
  type        = string
  description = "GCP organization ID that holds billing account."
}

variable "billing_account_id" {
  type        = string
  description = "The GCP billing account in your organization."
}

variable "landing_zone_folder_ids" {
  type        = list(string)
  description = "GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders."
}

variable "cloud_billing_export_project_id" {
  type        = string
  description = "GCP Project where the BiqQery table resides that holds the Cloud Billing export to BigQuery. See https://cloud.google.com/billing/docs/how-to/export-data-bigquery"
}

variable "cloud_billing_export_dataset_id" {
  type        = string
  description = "GCP BigQuery dataset containing the Cloud Billing BigQuery export."
}

variable "cloud_billing_export_table_id" {
  type        = string
  description = "GCP BigQuery table containing the Cloud Billing BigQuery export."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "replicator_sa_name" {
  type        = string
  description = "Name of the service account to create for Replicator."
  default     = "mesh-replicator-service-tf"
}

variable "kraken_sa_name" {
  type        = string
  description = "Name of the service account to create for Kraken."
  default     = "mesh-kraken-service-tf"
}
