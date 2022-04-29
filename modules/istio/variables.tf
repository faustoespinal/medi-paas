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
