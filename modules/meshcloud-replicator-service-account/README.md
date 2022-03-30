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
| [google_billing_account_iam_member.replicator_service](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/billing_account_iam_member) | resource |
| [google_folder_iam_member.replicator_service](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/folder_iam_member) | resource |
| [google_organization_iam_custom_role.replicator_billing](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_custom_role.replicator_service](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/organization_iam_custom_role) | resource |
| [google_project_service.admin_api](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_service) | resource |
| [google_project_service.cloudbilling_api](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_service) | resource |
| [google_project_service.cloudresourcemanager_api](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_service) | resource |
| [google_service_account.replicator_service](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/service_account) | resource |
| [google_service_account_key.sa_key](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/service_account_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The GCP Billing Account in your organization. | `string` | n/a | yes |
| <a name="input_billing_org_id"></a> [billing\_org\_id](#input\_billing\_org\_id) | GCP Organization Id that holds billing account | `string` | n/a | yes |
| <a name="input_landing_zone_folder_ids"></a> [landing\_zone\_folder\_ids](#input\_landing\_zone\_folder\_ids) | GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders. | `set(string)` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization Id | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID where to create the resources. This is typically a 'meshstack-root' project | `string` | n/a | yes |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | name of the service account to create | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_replicator_manual_setup"></a> [replicator\_manual\_setup](#output\_replicator\_manual\_setup) | Replicator service account setup information. |
| <a name="output_sa_email"></a> [sa\_email](#output\_sa\_email) | Service account email. |
| <a name="output_sa_key"></a> [sa\_key](#output\_sa\_key) | Service account key (base64 encoded credential.json). |
| <a name="output_sa_unique_id"></a> [sa\_unique\_id](#output\_sa\_unique\_id) | The unique ID of the Service Account |
