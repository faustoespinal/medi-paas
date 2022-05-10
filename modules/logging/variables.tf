variable "release_name" {
  type    = string
  default = "loki"
}
variable "chart_name" {
  type    = string
  default = "loki-stack"
}

variable "module_root" {
  type    = string
  default = "."
}

variable "repository_name" {
  type    = string
  default = "https://grafana.github.io/helm-charts"
}

variable "namespace" {
  type    = string
  default = "md-logging"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "release_creator" {
  type    = string
  description = "The installer of this module"
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

variable "host_aliases" {
  description = "List of host aliases"
  type        = object({
                  hosts = list(string)
                  ips = list(string)
                })
  default     = {
    hosts = []
    ips = []
  }
}
