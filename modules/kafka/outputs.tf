output "namespace" {
  description = "Namespace output parameter from kafka"
  value       = helm_release.kafka.namespace
}

output "release_name" {
  description = "Namespace output parameter from kafka"
  value       = helm_release.kafka.name
}

