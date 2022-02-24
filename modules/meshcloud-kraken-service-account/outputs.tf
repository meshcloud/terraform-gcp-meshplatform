output "sa_key" {
  value       = google_service_account_key.sa_key.private_key
  description = "Service account key (base64 encoded credential.json)"
}
