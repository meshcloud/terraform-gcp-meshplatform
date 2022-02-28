variable "sa_email" {
  type        = string
  description = "Email of the meshcloud replicator service account to grant access to the Bucket where the GDM Templates are stored"
}

variable "project_id" {
  type        = string
  description = "GCP Project Id where the bucket is located"
}

variable "bucket_name" {
  type        = string
  description = "The bucket name in the project where the GDM Templates are stored"
}
