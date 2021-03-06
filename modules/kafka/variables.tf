variable "release_creator" {
  type    = string
  default = "md-paas"
}
variable "release_name" {
  type    = string
  default = "kafka"
}
variable "chart_name" {
  type    = string
  default = "kafka"
}

variable "repository_name" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "namespace" {
  type    = string
  default = "md-messaging"
}

variable "module_root" {
  type    = string
  default = "."
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

