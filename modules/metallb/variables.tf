variable "release_creator" {
  type    = string
  default = "md-paas"
}
variable "release_name" {
  type    = string
  default = "metallb"
}
variable "chart_name" {
  type    = string
  default = "metallb"
}

variable "repository_name" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "namespace" {
  type    = string
  default = "md-network"
}

variable "values_file_path" {
  type = string
  default = "values.yaml"
}

variable "create_namespace" {
  type    = bool
  default = true
}

