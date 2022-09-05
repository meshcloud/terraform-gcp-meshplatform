output "replicator_sa_email" {
  value       = module.replicator_sa.sa_email
  description = "Replicator service account email."
}

output "replicator_sa_credentials_json" {
  description = "Replicator service account key in credentials.json format, base64 encoded."
  value       = module.replicator_sa.sa_key
  sensitive   = true
}

output "replicator_manual_setup" {
  description = "Replicator service account setup information."
  value       = module.replicator_sa.replicator_manual_setup
}

output "kraken_sa_email" {
  value       = module.kraken_sa.sa_email
  description = "Kraken service account email."
}

output "kraken_sa_credentials_json" {
  description = "Kraken service account key in credentials.json format, base64 encoded."
  value       = module.kraken_sa.sa_key
  sensitive   = true
}

output "cloud_billing_export_table_name" {
  description = "The BigQuery table name containing the GCP Cloud Billing BigQuery export."
  value       = "${var.cloud_billing_export_project_id}.${var.cloud_billing_export_dataset_id}.${var.cloud_billing_export_table_id}"
}

output "carbon_footprint_export_table_name" {
  description = "The BigQuery table name containing the GCP Carbon Footprint BigQuery export."
  value       = try(module.carbon_export[0].carbon_footprint_export_table_name, null)
}
