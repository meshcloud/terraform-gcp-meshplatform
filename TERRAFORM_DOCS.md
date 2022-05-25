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
| <a name="input_carbon_footprint_dataset_id"></a> [carbon\_footprint\_dataset\_id](#input\_carbon\_footprint\_dataset\_id) | Id of BigQuery dataset for carbon footprint. | `string` | `"carbon_footprint_data"` | no |
| <a name="input_carbon_footprint_dataset_location"></a> [carbon\_footprint\_dataset\_location](#input\_carbon\_footprint\_dataset\_location) | Location of BigQuery dataset for carbon footprint. | `string` | `"us-west1"` | no |
| <a name="input_cloud_billing_export_dataset_id"></a> [cloud\_billing\_export\_dataset\_id](#input\_cloud\_billing\_export\_dataset\_id) | GCP BigQuery dataset containing the Cloud Billing BigQuery export. This variable is only required to form the output for meshPlatform configuration. No resources are created or attached. | `string` | n/a | yes |
| <a name="input_cloud_billing_export_project_id"></a> [cloud\_billing\_export\_project\_id](#input\_cloud\_billing\_export\_project\_id) | GCP Project where the BiqQuery table resides that holds the Cloud Billing export to BigQuery. See https://cloud.google.com/billing/docs/how-to/export-data-bigquery | `string` | n/a | yes |
| <a name="input_cloud_billing_export_table_id"></a> [cloud\_billing\_export\_table\_id](#input\_cloud\_billing\_export\_table\_id) | GCP BigQuery table containing the Cloud Billing BigQuery export. This variable is only required to form the output for meshPlatform configuration. No resources are created or attached. | `string` | n/a | yes |
| <a name="input_kraken_sa_name"></a> [kraken\_sa\_name](#input\_kraken\_sa\_name) | Name of the service account to create for Kraken. | `string` | `"mesh-kraken-service-tf"` | no |
| <a name="input_landing_zone_folder_ids"></a> [landing\_zone\_folder\_ids](#input\_landing\_zone\_folder\_ids) | GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders. | `list(string)` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID that holds the projects that generate billing data that the service account should import. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID where to create the resources. This is typically a 'meshstack-root' project. | `string` | n/a | yes |
| <a name="input_replicator_sa_name"></a> [replicator\_sa\_name](#input\_replicator\_sa\_name) | Name of the service account to create for Replicator. | `string` | `"mesh-replicator-service-tf"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_billing_export_table_name"></a> [cloud\_billing\_export\_table\_name](#output\_cloud\_billing\_export\_table\_name) | The BigQuery table name containing the GCP Cloud Billing BigQuery export. |
| <a name="output_kraken_sa_email"></a> [kraken\_sa\_email](#output\_kraken\_sa\_email) | Kraken service account email. |
| <a name="output_kraken_sa_key"></a> [kraken\_sa\_key](#output\_kraken\_sa\_key) | Kraken service account key. |
| <a name="output_replicator_manual_setup"></a> [replicator\_manual\_setup](#output\_replicator\_manual\_setup) | Replicator service account setup information. |
| <a name="output_replicator_sa_email"></a> [replicator\_sa\_email](#output\_replicator\_sa\_email) | Replicator service account email. |
| <a name="output_replicator_sa_key"></a> [replicator\_sa\_key](#output\_replicator\_sa\_key) | Replicator service account key (base64 encoded credential.json). |
