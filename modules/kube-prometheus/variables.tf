variable "release_name" {
  type    = string
  default = "prometheus"
}
variable "chart_name" {
  type    = string
  default = "kube-prometheus-stack"
}

variable "module_root" {
  type    = string
  default = "."
}

variable "repository_name" {
  type    = string
  default = "https://prometheus-community.github.io/helm-charts"
}

variable "namespace" {
  type    = string
  default = "md-monitoring"
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

