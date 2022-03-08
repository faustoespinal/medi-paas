output "namespace" {
  description = "Namespace output parameter from opa-envoy"
  value       = helm_release.opa_envoy.namespace
}

output "release_name" {
  description = "Namespace output parameter from opa-envoy"
  value       = helm_release.opa_envoy.name
}

output "module_status" {
  description = "Status output variable based on the status of last deployed helm chart"
  value       = helm_release.opa_envoy.metadata
}

