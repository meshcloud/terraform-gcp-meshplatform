output "replicator_sa_key" {
  sensitive = true
  value     = module.new_replicator_sa.sa_key
}

output "replicator_manual_setup" {
  value = module.new_replicator_sa.replicator_manual_setup
}

output "kraken_sa_key" {
  sensitive = true
  value     = module.new_kraken_sa.sa_key
}
