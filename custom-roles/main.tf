variable "org_id" {
  type        = string
  description = "Organization ID meshStack resources are under"
}

variable "project_id" {
  type        = string
  description = "Project ID meshStack resources are under"
}

# Organization-level permissions
resource "google_organization_iam_custom_role" "meshplatform_integrator" {
  role_id     = "meshplatform.integrator.org"
  org_id      = var.org_id
  title       = "meshPlatform Integrator Org"
  description = "Organization-level role for integrating GCP as a meshPlatform"
  permissions = [
    "iam.roles.list",
    "iam.roles.get",
    "iam.roles.create",
    "resourcemanager.folders.get",
    "resourcemanager.folders.getIamPolicy",
    "resourcemanager.folders.setIamPolicy",
    "billing.accounts.getIamPolicy",
    "billing.accounts.setIamPolicy",
  ]
}

# Project-level permissions
resource "google_project_iam_custom_role" "meshplatform_integrator" {
  role_id     = "meshplatform.integrator"
  project     = var.project_id
  title       = "meshPlatform Integrator"
  description = "Project-level role for integrating GCP as a meshPlatform"
  permissions = [
    "iam.serviceAccountKeys.create",
    "iam.serviceAccountKeys.get",
    "iam.serviceAccountKeys.list",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.getIamPolicy",
    "iam.serviceAccounts.setIamPolicy",
    "serviceusage.services.list",
    "serviceusage.services.use",
    "serviceusage.services.get",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",
  ]
}
