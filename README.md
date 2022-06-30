# GCP meshPlatform Module

Terraform module to integrate GCP as a meshPlatform into meshStack instance. With this module, service accounts used by meshStack are created with the required permissions.

<p align="center">
  <img src="/.github/Icon_GCP_Meshi_Hugs.png" width="250">
</p>

## Prerequisites

To run this module, you need the following:

- Required permissions. The user or service account applying this module needs the following permissions:
  
  Project-level:

    ```hcl
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
    # Only required when you need your landing zone to invoke a cloud function
    "cloudfunctions.functions.getIamPolicy",
    "cloudfunctions.functions.setIamPolicy"
    ```

  Organization-level:

    ```hcl
    "iam.roles.list",
    "iam.roles.get",
    "iam.roles.create",
    "iam.roles.undelete",
    "iam.roles.update",
    "resourcemanager.folders.get",
    "resourcemanager.folders.getIamPolicy",
    "resourcemanager.folders.setIamPolicy",
    "billing.accounts.getIamPolicy",
    "billing.accounts.setIamPolicy",
    # Only required when you need your landing zone to access the bucket containing your GDM templates
    "storage.buckets.getIamPolicy",
    "storage.buckets.setIamPolicy",
    ```

  You can create [custom roles](./custom-roles/main.tf) and assign them to the identity applying those modules.

- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [gcloud installed](https://cloud.google.com/sdk/docs/install)

Additionally, after the module has run, one of the Service Accounts needs to be granted a role in the Admin Console (Workspace). This can only be done by Super Administrators.

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

2. Download the example `main.tf` and `outputs.tf` files.

    ```sh
    # Downloads main.tf and outputs.tf files into ~/terraform-gcp-meshplatform
    wget https://raw.githubusercontent.com/meshcloud/terraform-gcp-meshplatform/main/examples/basic-gcp-integration/main.tf -P ~/terraform-gcp-meshplatform
    wget https://raw.githubusercontent.com/meshcloud/terraform-gcp-meshplatform/main/examples/basic-gcp-integration/outputs.tf -P ~/terraform-gcp-meshplatform
    ```

3. Execute the module.

    ```sh
    # Changes into ~/terraform-gcp-meshplatform and applies terraform
    cd ~/terraform-gcp-meshplatform
    terraform init
    terraform apply
    ```

4. Access terraform output and pass it securely to meshcloud.

    ```sh
    # The JSON output contains sensitive values that must not be transmitted to meshcloud in plain text.
    terraform output -json
    ```

5. Authorize the Replicator Service Account.

    The replicator service account needs the "Groups Admin" role from the Admin Console (Workspace) to manage permissions for managed GCP projects.
    To authorize the Service Account **via the Google Admin Console** navigate to `@Account` in the sidebar and then `Admin Roles -> Groups Admin` and click `Assign Service Accounts`. In the prompt that appears, enter the service account email, which looks like `user@project.iam.gserviceaccount.com`.

## Example Usages

Check [examples](./examples/) for different use cases. As a quick start we recommend using [basic-gcp-integration](./examples/basic-gcp-integration) example.
