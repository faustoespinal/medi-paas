output "namespace" {
  description = "Namespace output parameter from prometheus"
  value       = helm_release.prometheus.namespace
}

output "release_name" {
  description = "Namespace output parameter from prometheus"
  value       = helm_release.prometheus.name
}

