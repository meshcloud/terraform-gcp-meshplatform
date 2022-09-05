variable "cloud_carbon_export_project_id" {
  type        = string
  description = "GCP Project where the BiqQuery table resides that holds the Carbon Footprint export to BigQuery."
}

variable "cloud_carbon_export_dataset_id" {
  type        = string
  description = "GCP BigQuery dataset containing the Carbon Footprint BigQuery export."
}

variable "kraken_sa_email" {
  type        = string
  description = "Kraken Service account email address."
}