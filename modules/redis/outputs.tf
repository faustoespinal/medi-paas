output "namespace" {
  description = "Namespace output parameter from redis"
  value       = helm_release.redis.namespace
}

output "release_name" {
  description = "Namespace output parameter from redis"
  value       = helm_release.redis.name
}

