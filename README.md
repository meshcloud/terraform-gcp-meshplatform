# GCP meshPlatform Module

Terraform module to integrate GCP as a meshPlatform into meshStack instance. With this module, service accounts used by meshStack are created with the required permissions. The output of this module is a set of credentials that need to be configured in meshStack as described in [meshcloud public docs](https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform.html). 

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
    "cloudfunctions.functions.setIamPolicy",

    # Only required for the optional submodule for exporting carbon data  
    "resourcemanager.projects.update"
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
    "storage.buckets.setIamPolicy"
    ```

  You can create [custom roles](./custom-roles/main.tf) and assign them to the identity applying those modules.

- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [gcloud installed](https://cloud.google.com/sdk/docs/install)

Additionally, after the module has run, one of the Service Accounts needs to be granted a role in the Admin Console (Workspace). This can only be done by Super Administrators.

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

To provide some of the required variables, you will need to

- setup GCP Cloud Billing Export, see [cloud_billing_export_dataset_id](#input_cloud_billing_export_dataset_id)
- *optionally* setup GCP Cloud Carbon Footprint Exports, see [cloud_carbon_export_dataset_id](#input_cloud_carbon_export_dataset_id)

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

## Contributing Guide

Before opening a Pull Request, we recommend following the below steps to get a faster approval:

1. Install [pre-commit](https://pre-commit.com/#install)

   We use pre-commit to perform several terraform related tasks such as `terraform validate`, `terraform fmt`, and generating terraform docs with `terraform_docs`

2. Execute `pre-commit install`: Hooks configured in `.pre-commit-config.yaml` will be executed automatically on commit. For manual execution, you can use `pre-commit run -a`.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.11.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_carbon_export"></a> [carbon\_export](#module\_carbon\_export) | ./modules/meshcloud-carbon-export/ | n/a |
| <a name="module_kraken_sa"></a> [kraken\_sa](#module\_kraken\_sa) | ./modules/meshcloud-kraken-service-account/ | n/a |
| <a name="module_replicator_sa"></a> [replicator\_sa](#module\_replicator\_sa) | ./modules/meshcloud-replicator-service-account/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The GCP billing account in your organization. | `string` | n/a | yes |
| <a name="input_billing_org_id"></a> [billing\_org\_id](#input\_billing\_org\_id) | GCP organization ID that holds billing account. | `string` | n/a | yes |
| <a name="input_carbon_export_module_enabled"></a> [carbon\_export\_module\_enabled](#input\_carbon\_export\_module\_enabled) | Determines whether or not to include the resources of the carbon footprint export module. | `bool` | `false` | no |
| <a name="input_cloud_billing_export_dataset_id"></a> [cloud\_billing\_export\_dataset\_id](#input\_cloud\_billing\_export\_dataset\_id) | GCP BigQuery dataset containing the Cloud Billing BigQuery export.<br><br>    **ATTENTION**<br>    You need to manually configure the billing account big query export before exceuting this module.<br>    See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-gcp-manually.html#set-up-gcp-billing-data-export for instructions. | `string` | n/a | yes |
| <a name="input_cloud_billing_export_project_id"></a> [cloud\_billing\_export\_project\_id](#input\_cloud\_billing\_export\_project\_id) | GCP Project where the BiqQuery table resides that holds the Cloud Billing export to BigQuery. See https://cloud.google.com/billing/docs/how-to/export-data-bigquery | `string` | n/a | yes |
| <a name="input_cloud_billing_export_table_id"></a> [cloud\_billing\_export\_table\_id](#input\_cloud\_billing\_export\_table\_id) | GCP BigQuery table containing the Cloud Billing BigQuery export. This variable is only required to form the output for meshPlatform configuration. No resources are created or attached. | `string` | n/a | yes |
| <a name="input_cloud_carbon_export_dataset_id"></a> [cloud\_carbon\_export\_dataset\_id](#input\_cloud\_carbon\_export\_dataset\_id) | GCP BigQuery dataset containing the Carbon Footprint BigQuery export.<br><br>    **ATTENTION**<br>    You need to manually configure the carbon footprint export transfer config before exceuting this module.<br>    See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-gcp-manually.html#optional-enable-gcp-cloud-carbon-footprint-export for instructions." | `string` | n/a | yes |
| <a name="input_cloud_carbon_export_project_id"></a> [cloud\_carbon\_export\_project\_id](#input\_cloud\_carbon\_export\_project\_id) | GCP Project where the BiqQuery table resides that holds the Cloud Carbon Footprint export to BigQuery. | `string` | n/a | yes |
| <a name="input_kraken_sa_name"></a> [kraken\_sa\_name](#input\_kraken\_sa\_name) | Name of the service account to create for Kraken. | `string` | `"mesh-kraken-service-tf"` | no |
| <a name="input_landing_zone_folder_ids"></a> [landing\_zone\_folder\_ids](#input\_landing\_zone\_folder\_ids) | GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders. | `list(string)` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID that holds the projects that generate billing data that the service account should import. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID where to create the resources. This is typically a 'meshstack-root' project. | `string` | n/a | yes |
| <a name="input_replicator_sa_name"></a> [replicator\_sa\_name](#input\_replicator\_sa\_name) | Name of the service account to create for Replicator. | `string` | `"mesh-replicator-service-tf"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_carbon_footprint_export_table_name"></a> [carbon\_footprint\_export\_table\_name](#output\_carbon\_footprint\_export\_table\_name) | The BigQuery table name containing the GCP Carbon Footprint BigQuery export. |
| <a name="output_cloud_billing_export_table_name"></a> [cloud\_billing\_export\_table\_name](#output\_cloud\_billing\_export\_table\_name) | The BigQuery table name containing the GCP Cloud Billing BigQuery export. |
| <a name="output_kraken_sa_credentials_json"></a> [kraken\_sa\_credentials\_json](#output\_kraken\_sa\_credentials\_json) | Kraken service account key in credentials.json format, base64 encoded. |
| <a name="output_kraken_sa_email"></a> [kraken\_sa\_email](#output\_kraken\_sa\_email) | Kraken service account email. |
| <a name="output_replicator_manual_setup"></a> [replicator\_manual\_setup](#output\_replicator\_manual\_setup) | Replicator service account setup information. |
| <a name="output_replicator_sa_credentials_json"></a> [replicator\_sa\_credentials\_json](#output\_replicator\_sa\_credentials\_json) | Replicator service account key in credentials.json format, base64 encoded. |
| <a name="output_replicator_sa_email"></a> [replicator\_sa\_email](#output\_replicator\_sa\_email) | Replicator service account email. |
<!-- END_TF_DOCS -->
