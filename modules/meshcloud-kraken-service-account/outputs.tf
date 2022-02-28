output "sa_key" {
  value       = google_service_account_key.sa_key.private_key
  description = "Service account key (base64 encoded credential.json)."
  sensitive   = true
}

output "sa_email" {
  value       = google_service_account.meshcloud_kraken_sa.email
  description = "Service account email."
}
