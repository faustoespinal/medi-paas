output "namespace" {
  description = "Namespace output parameter from traefik"
  value       = helm_release.traefik.namespace
}

output "release_name" {
  description = "Namespace output parameter from traefik"
  value       = helm_release.traefik.name
}

