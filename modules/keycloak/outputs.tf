output "namespace" {
  description = "Namespace output parameter from keycloak"
  value       = helm_release.keycloak.namespace
}

output "release_name" {
  description = "Namespace output parameter from keycloak"
  value       = helm_release.keycloak.name
}

