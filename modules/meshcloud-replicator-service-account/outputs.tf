output "sa_unique_id" {
  value       = google_service_account.replicator_service.unique_id
  description = "The unique ID of the Service Account"
}

output "sa_key" {
  value       = google_service_account_key.sa_key.private_key
  description = "Service account key (base64 encoded credential.json)."
  sensitive   = true
}

output "sa_email" {
  value       = google_service_account.replicator_service.email
  description = "Service account email."
}

# further manual setup is required because currently there is no way to figure out the role id and do GSuite
# calls needed with Terraform. See this ticket in a custom TF module:
# https://github.com/DeviaVir/terraform-provider-gsuite/issues/147
output "replicator_manual_setup" {
  value       = <<EOF
  Attention. The created service account ${google_service_account.replicator_service.email} with the unique id '${google_service_account.replicator_service.unique_id}' needs a manual role assignment for the G Suite role 'Group Administrator' so necessary group operations can be performed domain-wide.
  See https://docs.meshcloud.io/docs/meshstack.gcp.index.html#authorizing-the-service-account for instructions.
  EOF
  description = "Replicator service account setup information."
}
