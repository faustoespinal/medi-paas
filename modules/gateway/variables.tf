variable "release_name" {
  type    = string
  default = "traefik"
}
variable "chart_name" {
  type    = string
  default = "traefik"
}

variable "repository_name" {
  type    = string
  default = "https://helm.traefik.io/traefik"
}

variable "namespace" {
  type    = string
  default = "md-security"
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

