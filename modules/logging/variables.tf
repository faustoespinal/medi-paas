variable "release_name" {
  type    = string
  default = "loki"
}
variable "chart_name" {
  type    = string
  default = "loki-stack"
}

variable "repository_name" {
  type    = string
  default = "https://grafana.github.io/helm-charts"
}

variable "namespace" {
  type    = string
  default = "md-logging"
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

