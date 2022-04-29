output "namespace" {
  description = "Namespace output parameter from oauth2-proxy"
  value       = helm_release.oauth2_proxy[0].namespace
}

output "release_name" {
  description = "Namespace output parameter from oauth2-proxy"
  value       = helm_release.oauth2_proxy[0].name
}

