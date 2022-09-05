output "carbon_footprint_export_table_name" {
  description = "The BigQuery table name containing the GCP Carbon Footprint BigQuery export."

  # note carbon_footprint is the default table name that google's data transfer config creates
  # we can't control this via terraform right now
  value = "${var.cloud_carbon_export_project_id}.${var.cloud_carbon_export_dataset_id}.carbon_footprint"
}
