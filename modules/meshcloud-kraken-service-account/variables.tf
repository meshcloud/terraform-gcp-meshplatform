variable "sa_name" {
  type        = string
  description = "name of the service account to create"
}

variable "org_id" {
  type        = string
  description = "GCP Organization ID that holds the projects that generate billing data that the service account should import."
}

variable "meshstack_root_project_id" {
  type        = string
  description = "GCP Project ID where to create the service account. This is typically a 'meshstack-root' project."
}

variable "billing_dataset_project_id" {
  type        = string
  description = "GCP Project ID where the biquery table resides that holds billing data export."
}

variable "landing_zone_folder_ids" {
  type        = set(string)
  description = "GCP Folders that make up the Landing Zone. The service account will only receive permissions on these folders."
}
