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

variable "organization" {
  type    = string
  default = "yunen"
  description = "Organization name for the authorization extensions"
}

variable "clients" {
  description = "List of OAuth clients to register with"
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
