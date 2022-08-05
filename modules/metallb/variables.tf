variable "release_creator" {
  type    = string
  default = "md-paas"
}

variable "module_root" {
  type    = string
  default = "."
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
  default = "https://metallb.github.io/metallb"
}

variable "namespace" {
  type    = string
  default = "metallb"
}

variable "values_file_path" {
  type = string
  default = "values.yaml"
}

variable "create_namespace" {
  type    = bool
  default = true
}

