output "sa_key" {
  value       = google_service_account_key.sa_key.private_key
  description = "Service Account Key (base64 encoded credential.json)"
}
