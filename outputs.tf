output "replicator_sa_key" {
  description = "Replicator service account key (base64 encoded credential.json)."
  value       = module.new_replicator_sa.sa_key
  sensitive   = true
}

output "replicator_manual_setup" {
  description = "Replicator service account setup information."
  value       = module.new_replicator_sa.replicator_manual_setup
}

output "kraken_sa_key" {
  description = "Kraken service account key."
  value       = module.new_kraken_sa.sa_key
  sensitive   = true
}
