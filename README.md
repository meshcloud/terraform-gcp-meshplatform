# meshPlatform GCP Module

Terraform module to integrate GCP as a meshPlatform into meshStack instance. With this module, service accounts used by meshStack are created with the required permissions.

## Prerequisites

To run this module, you need the following:

- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [gcloud installed](https://cloud.google.com/sdk/docs/install)

## Module Structure

For an overview of the module structure, refer to [generated terraform docs](./TERRAFORM_DOCS.md)

## How to Use This Module

Before using this module, you need a gcp project. We recommend creating a new project for meshcloud service accounts.

You can create a gcp project by adding this terraform block to your terraform file:

```hcl
resource "google_project" "meshstack_root" {
  name               = <PROJECT_NAME>
  project_id         = <PROJECT_ID>
  folder_id          = <FOLDER_ID>
  billing_account    = <BILLING_ACCOUNT_ID>
}
```

### Using CLI

1. login with your gcloud account.

   ```sh
   gcloud auth application-default login
   ```

2. Create a directory and change into it

   ```sh
   mkdir terraform-gcp-meshplatform
   cd terraform-gcp-meshplatform
   ```

3. Create a `main.tf` and an `output.tf` files in the created directory that references this module
   > See [Example Usages](#example-usages)

4. Run

    ```sh
    terraform init
    terraform apply
    ```

5. Access terraform output and pass it securely to meshcloud.

    ```sh
    # The JSON output contains sensitive values that must not be transmitted to meshcloud in plain text.
    terraform output -json
    ```

```hcl
module "meshplatform" {
  source = "git@github.com:meshcloud/terraform-gcp-meshplatform.git"

  # common parameters
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

## Example Usages

Check [examples](./examples/) for different use cases. As a quick start we recommend using [basic-gcp-integration](./examples/basic-gcp-integration) example.
