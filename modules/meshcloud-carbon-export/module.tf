# similar to the cost export, we expect that the dataset already exists and was setup externally
# this is a bit of a bummer as we can _almost_ automate it, see https://github.com/meshcloud/terraform-gcp-meshplatform/issues/10

resource "google_bigquery_dataset_iam_member" "read_carbon_export" {
  project    = var.cloud_carbon_export_project_id
  dataset_id = var.cloud_carbon_export_dataset_id

  member = "serviceAccount:${var.kraken_sa_email}"
  role   = "roles/bigquery.dataViewer"
}