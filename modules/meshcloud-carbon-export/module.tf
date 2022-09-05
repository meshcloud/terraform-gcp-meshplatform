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

data "google_client_openid_userinfo" "current" {
}


data "google_iam_policy" "carbon_export_transfer" {
  binding {
    role = "roles/iam.serviceAccountShortTermTokenMinter"

    members = ["serviceAccount:service-${data.google_project.carbon_data_export_project.number}@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"]
  }

  # the caller also needs permissions to act as the service account
  binding {
    role = "roles/iam.serviceAccountTokenCreator" 
    members = [
      length(regexall("iam.gserviceaccount.com", data.google_client_openid_userinfo.current.email)) > 0
        ? "serviceAccount:${data.google_client_openid_userinfo.current.email}"
        : "user:${data.google_client_openid_userinfo.current.email}"
    ]
  }
}
resource "google_service_account" "carbon_export_transfer" {
  project      = var.carbon_data_export_project_id
  account_id   = "carbon-export-transfer"
  display_name = "Carbon Footprint Export Transfer User"
  description  = "This SA is used to run the big query data transfer job loading carbon footprint information into the export dataset"
}

resource "google_service_account_iam_policy" "bigquerydatatransfer_permissions" {
  service_account_id = google_service_account.carbon_export_transfer.name
  policy_data        = data.google_iam_policy.carbon_export_transfer.policy_data
}

resource "google_bigquery_dataset_iam_binding" "carbon_export_transfer_permission" {
  project    = var.carbon_data_export_project_id
  dataset_id = google_bigquery_dataset.carbon_data_export_dataset.dataset_id
  members    = [
    "serviceAccount:${google_service_account.carbon_export_transfer.email}"
  ]
  role       = "roles/bigquery.user"
}

# It seems at the moment we cannot use service accounts to authenticate the transfer as Cloud Carbon Footprint
# is not a part of the currently supported data sources, see
# https://cloud.google.com/bigquery/docs/use-service-accounts#data_sources_with_service_account_support
resource "google_bigquery_data_transfer_config" "carbon_footprint_transfer_config" {
  provider = google.carbon

  depends_on = [
    google_bigquery_dataset_iam_binding.carbon_export_transfer_permission,
    google_service_account_iam_policy.bigquerydatatransfer_permissions
  ]
  project                = var.carbon_data_export_project_id

  display_name           = "carbon-footprint-export-tf"
  location               = var.carbon_dataset_region
  data_source_id         = "61cede5a-0000-2440-ad42-883d24f8f7b8"
  schedule               = "every day 08:00"
  destination_dataset_id = google_bigquery_dataset.carbon_data_export_dataset.dataset_id
  
  # service_account_name   = google_service_account.carbon_export_transfer.email

  params = {
    billing_accounts = var.billing_account_id
  }
}