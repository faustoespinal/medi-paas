variable "release_creator" {
  type    = string
  default = "md-paas"
}
variable "release_name" {
  type    = string
  default = "keycloak"
}
variable "chart_name" {
  type    = string
  default = "keycloak"
}

variable "module_root" {
  type    = string
  default = "."
}

variable "repository_name" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
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

variable "timeout" {
  type = number
  default = 600
}

