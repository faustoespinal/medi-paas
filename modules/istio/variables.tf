variable "release_name" {
  type    = string
  default = "istio"
}

variable "chart_name" {
  type    = string
  default = "istio"
}

variable "repository_name" {
  type    = string
  default = "https://istio-release.storage.googleapis.com/charts/"
}

variable "values_file_path" {
  type = string
  default = "values.yaml"
}

variable "namespace" {
  type = string
  default = "istio-system"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "release_creator" {
  type    = string
  description = "The installer of this module"
}

variable "module_root" {
  type    = string
  default = "."
}


