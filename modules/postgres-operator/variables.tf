variable "release_name" {
  type    = string
  default = "postgres-operator"
}
variable "chart_name" {
  type    = string
  default = "postgres-operator"
}

variable "repository_base" {
  type    = string
  default = "https://opensource.zalando.com/postgres-operator/charts"
}

variable "namespace" {
  type    = string
  default = "postgres-operator"
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

