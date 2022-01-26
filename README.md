# meshPlatform GCP Module

Terraform module to integrate GCP as a meshPlatform into meshStack instance.

With this module, service accounts used by meshStack are created with the required permissions.

# Usage

```hcl
module "meshplatform" {
  source = "git@github.com:meshcloud/terraform-gcp-meshplatform.git"

  # common parameters
  project_name =  "..."
  project_id = "..."
  org_id   = "..."
  landing_zone_folder_ids = [ "..." ]
  
  # required for replicator
  billing_org_id = "..."
  billing_account_id = "..."

  # required for kraken
  billing_dataset_project_id = "..."
}
```

This will create kraken and replicator service accounts.
