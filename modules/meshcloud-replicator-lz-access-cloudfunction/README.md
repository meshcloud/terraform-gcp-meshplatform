## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_cloudfunctions_function_iam_member.invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_function"></a> [cloud\_function](#input\_cloud\_function) | The cloud function name that the replicator ServiceAccount invokes | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project Id where the cloud function is located | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The location of this cloud function | `string` | n/a | yes |
| <a name="input_sa_email"></a> [sa\_email](#input\_sa\_email) | email of the meshcloud replicator ServiceAccount to invoke the cloud function | `string` | n/a | yes |

## Outputs

No outputs.
