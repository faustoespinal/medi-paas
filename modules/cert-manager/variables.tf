variable "release_name" {
  type    = string
  default = "cert-manager"
}
variable "chart_name" {
  type    = string
  default = "cert-manager"
}

variable "repository_name" {
  type    = string
  default = "https://charts.jetstack.io"
}

variable "namespace" {
  type    = string
  default = "md-security"
}

variable "values_file_path" {
  type = string
  default = "values.yaml"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "release_creator" {
  type    = string
  description = "The installer of this module"
}

variable "encryption_algorithm" {
  type    = string
  default = "ECDSA"
}

variable "encryption_size" {
  type    = number
  default = 256
}

variable "encryption_encoding" {
  type    = string
  default = "PKCS1"
}

