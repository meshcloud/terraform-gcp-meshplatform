resource "google_project_service" "bigquery_api" {
  project            = var.meshstack_root_project_id
  service            = "bigquery.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account" "meshcloud_kraken_sa" {
  account_id   = var.sa_name
  display_name = "${var.sa_name} service account"
  description  = "This service account is used by meshcloud to obtain billing and related information for the kraken module"
  project      = var.meshstack_root_project_id
}

resource "google_project_iam_member" "bigquery_jobuser" {
  project = var.meshstack_root_project_id
  role    = "roles/bigquery.jobUser"

  member = "serviceAccount:${google_service_account.meshcloud_kraken_sa.email}"
}

resource "google_project_iam_member" "biquery_dataViewer" {
  project = var.cloud_billing_export_project_id
  role    = "roles/bigquery.dataViewer"

  member = "serviceAccount:${google_service_account.meshcloud_kraken_sa.email}"
}

resource "google_organization_iam_custom_role" "meshcloud_kraken_sa" {
  role_id     = "${replace(var.sa_name, "-", "_")}_service"
  org_id      = var.org_id
  title       = "${var.sa_name} service role"
  description = "Role for ${var.sa_name} service account used for project billing. See https://docs.meshcloud.io/docs/meshstack.gcp.metering.html#service-account-configuration"
  permissions = [
    "resourcemanager.folders.get",
    "resourcemanager.folders.list",
    "resourcemanager.projects.get",
    "resourcemanager.projects.list",
  ]
}

# We apply a hardened security configuration, i.e. we assign permissions only on LZ folders instead of the organization
# root

resource "google_folder_iam_member" "replicator_service" {
  for_each = var.landing_zone_folder_ids

  folder = each.value
  role   = google_organization_iam_custom_role.meshcloud_kraken_sa.id
  member = "serviceAccount:${google_service_account.meshcloud_kraken_sa.email}"
}

# You can obtain the json representation of the sa key to put it into vault
# from the terraform state. Simply base64 decode what's in the private_key field
resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.meshcloud_kraken_sa.id
}
