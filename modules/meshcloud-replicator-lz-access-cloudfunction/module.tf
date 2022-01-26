# Grant Access to Landing Zone Functions
resource "google_cloudfunctions_function_iam_member" "invoker" {
  cloud_function = var.cloud_function
  project        = var.project_id
  region         = var.region
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${var.sa_email}"
}
