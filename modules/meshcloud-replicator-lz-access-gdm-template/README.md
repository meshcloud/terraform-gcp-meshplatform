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
| [google_project_iam_custom_role.replicator_service](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_iam_custom_role) | resource |
| [google_storage_bucket_iam_member.google_deployment_manager_service_account](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The bucket name in the project where the GDM Templates are stored | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project Id where the bucket is located | `string` | n/a | yes |
| <a name="input_sa_email"></a> [sa\_email](#input\_sa\_email) | Email of the meshcloud replicator service account to grant access to the Bucket where the GDM Templates are stored | `string` | n/a | yes |

## Outputs

No outputs.
