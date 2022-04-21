variable "release_creator" {
  type    = string
  default = "md-paas"
}
variable "release_name" {
  type    = string
  default = "oauth2-proxy"
}
variable "chart_name" {
  type    = string
  default = "oauth2-proxy"
}

variable "repository_name" {
  type    = string
  default = "https://oauth2-proxy.github.io/manifests"
}

variable "namespace" {
  type    = string
  default = ""
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

