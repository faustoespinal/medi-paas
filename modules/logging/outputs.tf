output "namespace" {
  description = "Namespace output parameter from loki"
  value       = helm_release.loki.namespace
}

output "release_name" {
  description = "Namespace output parameter from loki"
  value       = helm_release.loki.name
}

