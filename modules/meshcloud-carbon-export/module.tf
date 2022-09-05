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

# The GCP SA running BigQuery Data Transfers needs a service account locally in the project to run the job.
# This also requires that GCP's SA can mint short term tokens for executing the transfer job with that local SA.

data "google_iam_policy" "carbon_export_transfer" {
  binding {
    role = "roles/iam.serviceAccountShortTermTokenMinter"

    members = ["serviceAccount:service-${data.google_project.carbon_data_export_project.number}@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"]
  }
}
resource "google_service_account" "carbon_export_transfer" {
  account_id   = "carbon-export-transfer"
  display_name = "Carbon Footprint Export Transfer User"
  description  = "This SA is used to run the big query data transfer job loading carbon footprint information into the export dataset"
  project      = var.carbon_data_export_project_id
}

resource "google_service_account_iam_policy" "bigquerydatatransfer_permissions" {
  service_account_id = google_service_account.carbon_export_transfer.name
  policy_data        = data.google_iam_policy.carbon_export_transfer.policy_data
}

resource "google_bigquery_dataset_iam_binding" "carbon_export_transfer_permission" {
  dataset_id = google_bigquery_dataset.carbon_data_export_dataset.id
  members    = [google_service_account.carbon_export_transfer.email]
  role       = "roles/bigquery.user"
}

resource "google_bigquery_data_transfer_config" "carbon_footprint_transfer_config" {
  depends_on = [google_service_account_iam_policy.bigquerydatatransfer_permissions]

  display_name           = "carbon-footprint-export-tf"
  location               = var.carbon_dataset_region
  data_source_id         = "61cede5a-0000-2440-ad42-883d24f8f7b8"
  schedule               = "every day 00:00"
  destination_dataset_id = google_bigquery_dataset.carbon_data_export_dataset.dataset_id
  project                = var.carbon_data_export_project_id
  service_account_name   = google_service_account.carbon_export_transfer.email
  params = {
    billing_accounts = var.billing_account_id
  }
}