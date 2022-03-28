resource "google_service_account" "replicator_service" {
  account_id   = var.sa_name
  display_name = "${var.sa_name} service account"
  description  = "This service account is used by meshcloud to replicate the desired cloud state into GCP"
  project      = var.project_id
}

resource "google_project_service" "admin_api" {
  project            = var.project_id
  service            = "admin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbilling_api" {
  project            = var.project_id
  service            = "cloudbilling.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudresourcemanager_api" {
  project            = var.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_organization_iam_custom_role" "replicator_service" {
  role_id     = "${replace(var.sa_name, "-", "_")}_service"
  org_id      = var.org_id
  title       = "${var.sa_name} service role"
  description = "Role for ${var.sa_name} service account used for project replication. See https://docs.meshcloud.io/docs/meshstack.gcp.index.html#service-account-configuration"
  permissions = [
    "resourcemanager.folders.get",
    "resourcemanager.folders.list",
    "resourcemanager.organizations.get",
    "resourcemanager.projects.create",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.list",
    "resourcemanager.projects.move",
    "resourcemanager.projects.setIamPolicy",
    "resourcemanager.projects.update",
    "resourcemanager.projects.createBillingAssignment",
    "resourcemanager.projects.deleteBillingAssignment",

    "serviceusage.services.enable",
    "serviceusage.services.get",

    # The following permissions are required for GDM Integration
    "deploymentmanager.deployments.delete",
    "deploymentmanager.deployments.create",
    "deploymentmanager.deployments.update",
    "deploymentmanager.deployments.get",
  ]
}

resource "google_organization_iam_custom_role" "replicator_billing" {
  role_id     = "${replace(var.sa_name, "-", "_")}_billing"
  org_id      = var.billing_org_id
  title       = "${var.sa_name} billing role"
  description = "Role for the ${var.sa_name} service account to create Billing Associations. See https://docs.meshcloud.io/docs/meshstack.gcp.index.html#service-account-configuration"
  permissions = [
    "billing.resourceAssociations.create"
  ]
}

# We apply a hardened security configuration. We assign permissions only on LZ folders instead of the organization root.
resource "google_folder_iam_member" "replicator_service" {
  for_each = var.landing_zone_folder_ids

  folder = each.value
  role   = google_organization_iam_custom_role.replicator_service.id
  member = "serviceAccount:${google_service_account.replicator_service.email}"
}


/*
  Billing Accounts are associated with an organization and can thus inherit organization level role assignments
  see https://cloud.google.com/billing/docs/how-to/billing-access).

  The replicator needs the "billing.resourceAssociations.create" permission for the billing account. We
  don't want to use an organization level role assignment. It's not sufficient to create the role assignment on a folder level because the
  Billing Account "lives in the Organization" but outside the folder/project hierahchy. So we have to assign it the permission directly on the billing
  account. 
*/
resource "google_billing_account_iam_member" "replicator_service" {
  billing_account_id = var.billing_account_id
  role               = google_organization_iam_custom_role.replicator_billing.id
  member             = "serviceAccount:${google_service_account.replicator_service.email}"
}

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.replicator_service.id
}

