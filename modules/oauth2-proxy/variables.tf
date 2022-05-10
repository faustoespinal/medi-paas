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

variable "oauth_clients" {
  description = "List of OAuth clients and auto-generated secrets"
  type        = object({
                  monitoring_idx = number
                  logging_idx = number
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
    monitoring_idx = 0
    logging_idx = 0
  }
}
