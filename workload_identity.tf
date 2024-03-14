resource "google_iam_workload_identity_pool" "meshstack" {
  count = var.workload_identity_federation == null ? 0 : 1

  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_federation.workload_identity_pool_identifier
  description               = "Identity pool for meshStack workloads"
}

resource "google_iam_workload_identity_pool_provider" "meshstack" {
  count = var.workload_identity_federation == null ? 0 : 1

  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.meshstack[0].workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_federation.workload_identity_pool_identifier

  description = "OIDC identity provider for meshStack workloads"

  oidc {
    allowed_audiences = [var.workload_identity_federation.audience]
    issuer_uri        = var.workload_identity_federation.issuer
  }

  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }

  attribute_condition = "google.subject in ['${var.workload_identity_federation.replicator_subject}', '${var.workload_identity_federation.kraken_subject}']"
}
