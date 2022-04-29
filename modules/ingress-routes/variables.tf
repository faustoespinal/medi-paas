variable "release_creator" {
  type    = string
  default = "md-paas"
}

variable "release_name" {
  type    = string
  default = "istio-ingress-routes"
}

variable "chart_name" {
  type    = string
  default = "istio-ingress-routes"
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
  default = "istio-system"
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
