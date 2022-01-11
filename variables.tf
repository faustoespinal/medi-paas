variable "kube_context" {
  type    = string
  default = "karofa"
}

variable "release_creator" {
  type    = string
  default = "md-pass"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "system_profile_root" {
  type    = string
  default = "./modules"
  description = "The root path where to find the per chart module values.yaml"
}

# variable "application_name" {
#   type    = string
#   default = "terramino"
# }

# variable "slack_app_token" {
#   type        = string
#   description = "Slack App Token"
# }

