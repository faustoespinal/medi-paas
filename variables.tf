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

variable "prometheus_count" {
  type    = number
  default = 1
}

variable "redis_count" {
  type    = number
  default = 1
}

variable "gateway_count" {
  type    = number
  default = 1
}

variable "logging_count" {
  type    = number
  default = 1
}

variable "kafka_count" {
  type    = number
  default = 1
}

variable "certmanager_count" {
  type    = number
  default = 1
}

variable "keycloak_count" {
  type    = number
  default = 1
}

variable "dicom_count" {
  type    = number
  default = 1
}


# variable "application_name" {
#   type    = string
#   default = "terramino"
# }

# variable "slack_app_token" {
#   type        = string
#   description = "Slack App Token"
# }

