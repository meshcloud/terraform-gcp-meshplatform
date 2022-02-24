## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 3.34.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_new_kraken_sa"></a> [new\_kraken\_sa](#module\_new\_kraken\_sa) | ./modules/meshcloud-kraken-service-account/ | n/a |
| <a name="module_new_replicator_sa"></a> [new\_replicator\_sa](#module\_new\_replicator\_sa) | ./modules/meshcloud-replicator-service-account/ | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project.meshstack_root](https://registry.terraform.io/providers/hashicorp/google/3.34.0/docs/resources/project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The GCP billing account in your organization. | `string` | n/a | yes |
| <a name="input_billing_dataset_project_id"></a> [billing\_dataset\_project\_id](#input\_billing\_dataset\_project\_id) | GCP Project ID where the biquery table resides that holds billing data export. | `string` | n/a | yes |
| <a name="input_billing_org_id"></a> [billing\_org\_id](#input\_billing\_org\_id) | GCP organization ID that holds billing account | `string` | n/a | yes |
| <a name="input_kraken_sa_name"></a> [kraken\_sa\_name](#input\_kraken\_sa\_name) | Name of the service account to create for Kraken | `string` | `"mesh-kraken-service-tf"` | no |
| <a name="input_landing_zone_folder_ids"></a> [landing\_zone\_folder\_ids](#input\_landing\_zone\_folder\_ids) | GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders. | `list(string)` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID that holds the projects that generate billing data that the service account should import. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID where to create the resources. This is typically a 'meshstack-root' project | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | GCP Project name where to create the resources. This is typically a 'meshstack-root' project | `string` | n/a | yes |
| <a name="input_replicator_sa_name"></a> [replicator\_sa\_name](#input\_replicator\_sa\_name) | Name of the service account to create for Replicator | `string` | `"mesh-replicator-service-tf"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kraken_sa_key"></a> [kraken\_sa\_key](#output\_kraken\_sa\_key) | Kraken service account key. |
| <a name="output_replicator_manual_setup"></a> [replicator\_manual\_setup](#output\_replicator\_manual\_setup) | Replicator service account setup information. |
| <a name="output_replicator_sa_key"></a> [replicator\_sa\_key](#output\_replicator\_sa\_key) | Replicator service account key (base64 encoded credential.json). |
