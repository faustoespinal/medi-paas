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

variable "release_creator" {
  type    = string
  default = "md-paas"
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

variable "timeout" {
  type = number
  default = 600
}

variable "oauth_clients" {
  description = "List of OAuth clients and auto-generated secrets"
  type        = object({
                  name = list(string)
                  secret = list(string)
                  redirect_url = list(string)
                  upstreams = list(string)
                  authz = list(bool)
                })
  default     = {
    name = []
    secret = []
    redirect_url = []
    upstreams = []
    authz = []
  }
}
