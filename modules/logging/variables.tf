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
