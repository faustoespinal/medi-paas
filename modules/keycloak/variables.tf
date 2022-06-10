variable "release_creator" {
  type    = string
  default = "md-paas"
}
variable "release_name" {
  type    = string
  default = "keycloak"
}
variable "chart_name" {
  type    = string
  default = "keycloak"
}

variable "module_root" {
  type    = string
  default = "."
}

variable "repository_name" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
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

variable "timeout" {
  type = number
  default = 600
}

variable "encryption_algorithm" {
  type    = string
  default = "ECDSA"
}

variable "encryption_size" {
  type    = number
  default = 256
}

variable "encryption_encoding" {
  type    = string
  default = "PKCS1"
}

variable "clients" {
  description = "List of OAuth clients to register with keycloak"
  type = list(object({
    name = string
    description = string
    secret = string
    redirect_url= string
    upstreams = string
    authz = bool
    roles = list(object({
      name  = string
      level = string
    }))
  }))
  default = []
}

variable "organizations" {
  description = "List of organizational/realm descriptions"
  type = list(object({
    name = string
    id = string
    description = string
    org-roles = list(string)
    groups = list(object({
      name = string
      clients = list(string)
    }))
    users = list(object({
      name = string
      lastname = string
      username = string
      password = string
      groups = list(string)
    }))
  }))
  default = []
}
