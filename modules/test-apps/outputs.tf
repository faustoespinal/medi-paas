output "namespace" {
  description = "Namespace output parameter from test-apps"
  value       = helm_release.test_apps.namespace
}

output "release_name" {
  description = "Namespace output parameter from test-apps"
  value       = helm_release.test_apps.name
}

output "module_status" {
  description = "Status output variable based on the status of last deployed helm chart"
  value       = helm_release.test_apps.metadata
}

