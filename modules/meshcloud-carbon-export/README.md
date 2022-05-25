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
| [google_bigquery_data_transfer_config.carbon_footprint_transfer_config](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/bigquery_data_transfer_config) | resource |
| [google_bigquery_dataset.carbon_data_export_dataset](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/bigquery_dataset) | resource |
| [google_project_service.bigquery_api](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_service) | resource |
| [google_project_service.bigquerydatatransfer_api](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The GCP Billing Account in your organization. | `string` | n/a | yes |
| <a name="input_carbon_data_export_dataset_id"></a> [carbon\_data\_export\_dataset\_id](#input\_carbon\_data\_export\_dataset\_id) | GCP BigQuery dataset containing the Carbon Footprint BigQuery export | `string` | n/a | yes |
| <a name="input_carbon_data_export_project_id"></a> [carbon\_data\_export\_project\_id](#input\_carbon\_data\_export\_project\_id) | GCP Project where the BiqQuery table resides that holds the Carbon Footprint export to BigQuery. See https://cloud.google.com/billing/docs/how-to/export-data-bigquery | `string` | n/a | yes |
| <a name="input_carbon_dataset_region"></a> [carbon\_dataset\_region](#input\_carbon\_dataset\_region) | The location of the BigQuery dataset for carbon data exports. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_carbon_footprint_export_table_name"></a> [carbon\_footprint\_export\_table\_name](#output\_carbon\_footprint\_export\_table\_name) | The BigQuery table name containing the GCP Carbon Footprint BigQuery export. |
