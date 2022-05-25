## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_folder_iam_member.replicator_service](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/folder_iam_member) | resource |
| [google_organization_iam_custom_role.meshcloud_kraken_sa](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/organization_iam_custom_role) | resource |
| [google_project_iam_member.bigquery_jobuser](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.biquery_dataViewer](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_iam_member) | resource |
| [google_project_service.bigquery_api](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_service) | resource |
| [google_service_account.meshcloud_kraken_sa](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/service_account) | resource |
| [google_service_account_key.sa_key](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/service_account_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_billing_export_project_id"></a> [cloud\_billing\_export\_project\_id](#input\_cloud\_billing\_export\_project\_id) | GCP Project where the BigQuery table resides that holds the Cloud Billing export to BigQuery. | `string` | n/a | yes |
| <a name="input_landing_zone_folder_ids"></a> [landing\_zone\_folder\_ids](#input\_landing\_zone\_folder\_ids) | GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders. | `set(string)` | n/a | yes |
| <a name="input_meshstack_root_project_id"></a> [meshstack\_root\_project\_id](#input\_meshstack\_root\_project\_id) | GCP Project ID where to create the service account. This is typically a 'meshstack-root' project. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID that holds the projects that generate billing data that the service account should import. | `string` | n/a | yes |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | Name of the service account to create. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sa_email"></a> [sa\_email](#output\_sa\_email) | Service account email. |
| <a name="output_sa_key"></a> [sa\_key](#output\_sa\_key) | Service account key (base64 encoded credential.json). |
