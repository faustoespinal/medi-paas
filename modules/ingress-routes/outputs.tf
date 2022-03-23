output "namespace" {
  description = "Namespace output parameter from istio-ingress-routes"
  value       = helm_release.istio_ingress_routes.namespace
}

output "release_name" {
  description = "Namespace output parameter from istio-ingress-routes"
  value       = helm_release.istio_ingress_routes.name
}

output "module_status" {
  description = "Status output variable based on the status of last deployed helm chart"
  value       = helm_release.istio_ingress_routes.metadata
}

