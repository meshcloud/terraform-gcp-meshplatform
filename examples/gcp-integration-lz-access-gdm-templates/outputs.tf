output "replicator_sa_key" {
  description = "Replicator service account key (base64 encoded credential.json)."
  value       = module.meshplatform.replicator_sa_key
  sensitive   = true
}

output "replicator_manual_setup" {
  description = "Replicator service account setup information."
  value       = module.meshplatform.replicator_manual_setup
}

output "kraken_sa_key" {
  description = "Kraken service account key."
  value       = module.meshplatform.kraken_sa_key
  sensitive   = true
}