output "carbon_footprint_export_table_name" {
  description = "The BigQuery table name containing the GCP Carbon Footprint BigQuery export."
  value       = "${var.carbon_data_export_project_id}.${var.carbon_data_export_dataset_id}.${var.carbon_data_export_dataset_id}"
}