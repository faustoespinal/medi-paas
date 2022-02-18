output "namespace" {
  description = "Namespace output parameter from traefik"
  value       = helm_release.traefik.namespace
}

output "release_name" {
  description = "Namespace output parameter from traefik"
  value       = helm_release.traefik.name
}

output "module_status" {
  description = "Status output variable based on the status of last deployed helm chart"
  value       = helm_release.traefik.metadata
}
