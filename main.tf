module "kraken_sa" {
  source = "./modules/meshcloud-kraken-service-account/"

  sa_name                    = var.kraken_sa_name
  org_id                     = var.org_id
  meshstack_root_project_id  = var.project_id
  billing_dataset_project_id = var.billing_dataset_project_id
  landing_zone_folder_ids    = var.landing_zone_folder_ids
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
