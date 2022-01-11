variable "release_name" {
  type    = string
  default = "redis"
}
variable "chart_name" {
  type    = string
  default = "redis"
}

variable "repository_name" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "namespace" {
  type    = string
  default = "md-storage"
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

