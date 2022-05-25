module "kraken_sa" {
  source = "./modules/meshcloud-kraken-service-account/"

  sa_name                         = var.kraken_sa_name
  org_id                          = var.org_id
  meshstack_root_project_id       = var.project_id
  cloud_billing_export_project_id = var.cloud_billing_export_project_id
  landing_zone_folder_ids         = var.landing_zone_folder_ids
}

module "replicator_sa" {
  source = "./modules/meshcloud-replicator-service-account/"

  sa_name        = var.replicator_sa_name
  project_id     = var.project_id
  org_id         = var.org_id
  billing_org_id = var.billing_org_id

  landing_zone_folder_ids = var.landing_zone_folder_ids

  billing_account_id = var.billing_account_id
}

module "carbon_export" {
  source = "./modules/meshcloud-carbon-export/"
  count  = var.carbon_export_module_enabled ? 1 : 0

  carbon_data_export_dataset_id = var.carbon_footprint_dataset_id
  carbon_data_export_project_id = var.cloud_billing_export_project_id # using the same project as for billing
  carbon_dataset_region         = var.carbon_footprint_dataset_location

  billing_account_id = var.billing_account_id
}