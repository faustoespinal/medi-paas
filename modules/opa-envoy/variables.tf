variable "release_creator" {
  type    = string
  default = "md-paas"
}

variable "release_name" {
  type    = string
  default = "opa-istio"
}

variable "chart_name" {
  type    = string
  default = "opa-envoy"
}

variable "module_root" {
  type    = string
  default = "."
}

variable "repository_name" {
  type    = string
  default = ""
}

variable "namespace" {
  type    = string
  default = "opa-istio"
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

