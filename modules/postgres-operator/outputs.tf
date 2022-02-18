output "namespace" {
  description = "Namespace output parameter from postgres-operator"
  value       = helm_release.postgres_operator.namespace
}

output "release_name" {
  description = "Namespace output parameter from postgres-operator"
  value       = helm_release.postgres_operator.name
}

