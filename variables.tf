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

variable "cert_encryption_algorithm" {
  type    = string
  default = "ECDSA"
  description = "ECDSA"
}

variable "cert_encryption_size" {
  type    = number
  default = 256
  description = "Encryption key size"
}

variable "cert_encryption_encoding" {
  type    = string
  default = "PKCS1"
  description = "Encryption key encoding"
}

variable "istio_count" {
  type    = number
  default = 1
}

variable "istioingress_count" {
  type    = number
  default = 1
}

variable "prometheus_count" {
  type    = number
  default = 1
}

variable "redis_count" {
  type    = number
  default = 1
}

variable "postgres_operator_count" {
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

