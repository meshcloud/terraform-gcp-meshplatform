<!-- BEGIN_TF_DOCS -->
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
| [google_bigquery_dataset_iam_member.read_carbon_export](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/bigquery_dataset_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_carbon_export_dataset_id"></a> [cloud\_carbon\_export\_dataset\_id](#input\_cloud\_carbon\_export\_dataset\_id) | GCP BigQuery dataset containing the Carbon Footprint BigQuery export | `string` | n/a | yes |
| <a name="input_cloud_carbon_export_project_id"></a> [cloud\_carbon\_export\_project\_id](#input\_cloud\_carbon\_export\_project\_id) | GCP Project where the BiqQuery table resides that holds the Carbon Footprint export to BigQuery. See https://cloud.google.com/billing/docs/how-to/export-data-bigquery | `string` | n/a | yes |
| <a name="input_kraken_sa_email"></a> [kraken\_sa\_email](#input\_kraken\_sa\_email) | Kraken Service account email address. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_carbon_footprint_export_manual_setup"></a> [carbon\_footprint\_export\_manual\_setup](#output\_carbon\_footprint\_export\_manual\_setup) | GCP Cloud Carbon Footprint BigQuery export manual setup information. |
| <a name="output_carbon_footprint_export_table_name"></a> [carbon\_footprint\_export\_table\_name](#output\_carbon\_footprint\_export\_table\_name) | The BigQuery table name containing the GCP Carbon Footprint BigQuery export. |
<!-- END_TF_DOCS -->