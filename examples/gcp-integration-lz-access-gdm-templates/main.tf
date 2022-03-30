# It is highly recommended to setup a backend to store the terraform state file
# Removing the backend will output the terraform state in the local filesystem
# See https://www.terraform.io/language/settings/backends for more details
#
# Remove/comment the backend block below if you are only testing the module.
# Please be aware that you cannot destroy the created resources via terraform if you lose the state file.
terraform {
  backend "gcs" {
    prefix = "meshplatforms/gcp"
    bucket = "my-terraform-states"
  }
}

# Details of the parameters are in the module structure input description (top level TERRAFORM_DOCS.md)
module "meshplatform" {
  source = "git::https://github.com/meshcloud/terraform-gcp-meshplatform.git"

  # common parameters
  project_id = "..."
  org_id     = "..."
  landing_zone_folder_ids = [
    "..."
  ]

  # required for replicator
  billing_org_id     = "..."
  billing_account_id = "..."

  # required for kraken
  cloud_billing_export_project_id = "..."
  cloud_billing_export_dataset_id = "..."
  cloud_billing_export_table_id   = "..."
}

# Details of the parameters are in the module structure input description (module README.md)
module "gdm_access" {
  source = "git::https://github.com/meshcloud/terraform-gcp-meshplatform.git//modules/meshcloud-replicator-lz-access-gdm-template/"

  project_id  = "..."
  bucket_name = "..."
  sa_email    = module.meshplatform.replicator_sa_email
}
