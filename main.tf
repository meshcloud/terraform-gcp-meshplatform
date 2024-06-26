module "kraken_sa" {
  source = "./modules/meshcloud-kraken-service-account/"

  sa_name                   = var.kraken_sa_name
  org_id                    = var.org_id
  meshstack_root_project_id = var.project_id
  landing_zone_folder_ids   = var.landing_zone_folder_ids

  cloud_billing_export_project_id = var.cloud_billing_export_project_id
  cloud_billing_export_dataset_id = var.cloud_billing_export_dataset_id

  service_account_key = var.service_account_keys
  workload_identity_federation = var.workload_identity_federation == null ? null : {
    pool_id = google_iam_workload_identity_pool.meshstack[0].name
    subject = var.workload_identity_federation.kraken_subject
  }
}

module "replicator_sa" {
  source = "./modules/meshcloud-replicator-service-account/"

  sa_name        = var.replicator_sa_name
  project_id     = var.project_id
  org_id         = var.org_id
  billing_org_id = var.billing_org_id

  landing_zone_folder_ids = var.landing_zone_folder_ids

  can_delete_projects_in_landing_zone_folder_ids = var.can_delete_projects_in_landing_zone_folder_ids

  billing_account_id = var.billing_account_id

  service_account_key = var.service_account_keys
  workload_identity_federation = var.workload_identity_federation == null ? null : {
    pool_id = google_iam_workload_identity_pool.meshstack[0].name
    subject = var.workload_identity_federation.replicator_subject
  }
}

module "carbon_export" {
  source = "./modules/meshcloud-carbon-export/"
  count  = var.carbon_export_module_enabled ? 1 : 0

  kraken_sa_email = module.kraken_sa.sa_email

  cloud_carbon_export_project_id = var.cloud_carbon_export_project_id # using the same project as for billing
  cloud_carbon_export_dataset_id = var.cloud_carbon_export_dataset_id
}
