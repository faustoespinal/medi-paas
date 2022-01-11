output "namespace" {
  description = "Namespace output parameter from metallb"
  value       = helm_release.metallb.namespace
}

output "release_name" {
  description = "Namespace output parameter from metallb"
  value       = helm_release.metallb.name
}

