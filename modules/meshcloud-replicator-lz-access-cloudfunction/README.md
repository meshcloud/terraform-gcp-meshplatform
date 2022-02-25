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
| [google_cloudfunctions_function_iam_member.invoker](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/cloudfunctions_function_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_function"></a> [cloud\_function](#input\_cloud\_function) | The cloud function name that the replicator service account invokes | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project Id where the cloud function is located | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The location of this cloud function | `string` | n/a | yes |
| <a name="input_sa_email"></a> [sa\_email](#input\_sa\_email) | Email of the meshcloud replicator service account to invoke the cloud function | `string` | n/a | yes |

## Outputs

No outputs.
