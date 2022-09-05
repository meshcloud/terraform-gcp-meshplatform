resource "google_project_service" "bigquery_api" {
  project            = var.carbon_data_export_project_id
  service            = "bigquery.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "bigquerydatatransfer_api" {
  project            = var.carbon_data_export_project_id
  service            = "bigquerydatatransfer.googleapis.com"
  disable_on_destroy = false
}

resource "google_bigquery_dataset" "carbon_data_export_dataset" {
  dataset_id    = var.carbon_data_export_dataset_id
  friendly_name = "carbon_data_export_tf"
  description   = "This dataset holds the carbon footprint data."
  location      = var.carbon_dataset_region
  project       = var.carbon_data_export_project_id
}

data "google_project" "carbon_data_export_project" {
  project_id = var.carbon_data_export_project_id
}

# allow the GCP SA running BigQuery Data Transfers to mint short term tokens for executing the transfer job
resource "google_project_iam_member" "bigquerydatatransfer_permissions" {
  project = data.google_project.carbon_data_export_project.project_id
  role   = "roles/iam.serviceAccountShortTermTokenMinter"
  member = "serviceAccount:service-${data.google_project.carbon_data_export_project.number}@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"
}

resource "google_bigquery_data_transfer_config" "carbon_footprint_transfer_config" {
  depends_on = [google_project_iam_member.bigquerydatatransfer_permissions]

  display_name           = "carbon-footprint-export-tf"
  location               = var.carbon_dataset_region
  data_source_id         = "61cede5a-0000-2440-ad42-883d24f8f7b8"
  schedule               = "every day 00:00"
  destination_dataset_id = google_bigquery_dataset.carbon_data_export_dataset.dataset_id
  project                = var.carbon_data_export_project_id
  params = {
    billing_accounts = var.billing_account_id
  }
}