output "replicator_sa_key" {
  description = "Replicator service account key (base64 encoded credential.json)."
  value       = module.replicator_sa.sa_key
  sensitive   = true
}

output "replicator_manual_setup" {
  description = "Replicator service account setup information."
  value       = module.replicator_sa.replicator_manual_setup
}

output "kraken_sa_key" {
  description = "Kraken service account key."
  value       = module.kraken_sa.sa_key
  sensitive   = true
}
