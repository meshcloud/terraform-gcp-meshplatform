output "sa_key" {
  value       = google_service_account_key.sa_key.private_key
  description = "Service account key (base64 encoded credential.json)."
  sensitive   = true
}

output "sa_email" {
  value       = google_service_account.meshcloud_kraken_sa.email
  description = "Service account email."
}

output "billing_export_manual_setup" {
  description = "GCP Cloud Billing BigQuery export manual setup information."
  value       = "Attention. You need to manually configure the billing account big query export before exceuting this module. See https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform-gcp-manually.html#set-up-gcp-billing-data-export for instructions."
}
