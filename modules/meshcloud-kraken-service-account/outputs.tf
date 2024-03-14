output "sa_key" {
  value       = var.service_account_key ? google_service_account_key.sa_key[0].private_key : null
  description = "Service account key (base64 encoded credential.json)."
  sensitive   = true
}

output "sa_email" {
  value       = google_service_account.meshcloud_kraken_sa.email
  description = "Service account email."
}
