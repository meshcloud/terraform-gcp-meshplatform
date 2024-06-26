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

resource "google_bigquery_dataset_iam_member" "read_billing_export" {
  project    = var.cloud_billing_export_project_id
  dataset_id = var.cloud_billing_export_dataset_id

  member = "serviceAccount:${google_service_account.meshcloud_kraken_sa.email}"
  role   = "roles/bigquery.dataViewer"
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
# root - this allows kraken to read projects

resource "google_folder_iam_member" "kraken_service" {
  for_each = var.landing_zone_folder_ids

  folder = each.value
  role   = google_organization_iam_custom_role.meshcloud_kraken_sa.id
  member = "serviceAccount:${google_service_account.meshcloud_kraken_sa.email}"
}

resource "google_service_account_key" "sa_key" {
  count              = var.service_account_key ? 1 : 0
  service_account_id = google_service_account.meshcloud_kraken_sa.id
}

moved {
  from = google_service_account_key.sa_key
  to   = google_service_account_key.sa_key[0]
}

# For workload identity federation create an IAM policy allowing the kraken subject to impersonate the service account.
resource "google_service_account_iam_member" "kraken" {
  count = var.workload_identity_federation == null ? 0 : 1

  service_account_id = google_service_account.meshcloud_kraken_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${var.workload_identity_federation.pool_id}/subject/${var.workload_identity_federation.subject}"
}

# Cloud functions must be called with ID tokens but after impersonation we only have an access token and must explicitly create an ID token.
resource "google_service_account_iam_member" "kraken_id_token" {
  for_each = var.workload_identity_federation == null ? {} : { 0 = "roles/iam.serviceAccountOpenIdTokenCreator", 1 = "roles/iam.serviceAccountTokenCreator" }

  service_account_id = google_service_account.meshcloud_kraken_sa.id
  role               = each.value
  member             = "serviceAccount:${google_service_account.meshcloud_kraken_sa.email}"
}
