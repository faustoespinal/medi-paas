output "namespace" {
  description = "Namespace output parameter from istio"
  value       = helm_release.istio_base.namespace
}

output "release_name" {
  description = "Release name output parameter from istio"
  value       = helm_release.istio_base.name
}

output "module_status" {
  description = "Status output variable based on the status of last deployed helm chart"
  value       = helm_release.istiod.metadata
}

