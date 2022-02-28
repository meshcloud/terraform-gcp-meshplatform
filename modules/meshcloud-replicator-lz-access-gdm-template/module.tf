# This role can also be defined on the infrastructure project holding the buckets for Landing Zone GDM Templates.
# In this setup the role is defined on the organization level, so it can be used for buckets in different projects.
locals {
  sa_name = split("@", var.sa_email)[0]
}

resource "google_project_iam_custom_role" "replicator_service" {
  role_id     = "${replace(local.sa_name, "-", "_")}_gdm_bucket_access"
  project     = var.project_id
  title       = "${local.sa_name} GDM template bucket access"
  description = "Role for ${local.sa_name} service account to access GDM Templates referenced in Landing Zones. See https://docs.meshcloud.io/docs/meshstack.gcp.landing-zones.html"
  permissions = [
    "storage.buckets.get",
    "storage.buckets.getIamPolicy",
    "storage.buckets.list",
    "storage.buckets.setIamPolicy",
    "storage.objects.get",
    "storage.objects.list",
  ]
}

resource "google_storage_bucket_iam_member" "google_deployment_manager_service_account" {
  bucket = var.bucket_name
  role   = google_project_iam_custom_role.replicator_service.id
  member = "serviceAccount:${var.sa_email}"
}
