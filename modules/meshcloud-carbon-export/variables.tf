variable "carbon_dataset_region" {
  type        = string
  description = "The location of the BigQuery dataset for carbon data exports."
}

variable "billing_account_id" {
  type        = string
  description = "The GCP Billing Account in your organization."
}

variable "carbon_data_export_project_id" {
  type        = string
  description = "GCP Project where the BiqQuery table resides that holds the Carbon Footprint export to BigQuery. See https://cloud.google.com/billing/docs/how-to/export-data-bigquery"
}

variable "carbon_data_export_dataset_id" {
  type        = string
  description = "GCP BigQuery dataset containing the Carbon Footprint BigQuery export"
}