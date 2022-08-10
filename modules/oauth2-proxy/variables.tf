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

variable "create_namespace" {
  type    = bool
  default = true
}

variable "timeout" {
  type = number
  default = 600
}

variable "ingress_ip" {
  type = string
  default = "0.0.0.0"
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
