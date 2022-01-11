output "namespace" {
  description = "Namespace output parameter from cert-manager"
  value       = helm_release.cert_manager.namespace
}

output "release_name" {
  description = "Namespace output parameter from cert-manager"
  value       = helm_release.cert_manager.name
}

