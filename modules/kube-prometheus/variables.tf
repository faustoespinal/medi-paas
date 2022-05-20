variable "release_name" {
  type    = string
  default = "prometheus"
}
variable "chart_name" {
  type    = string
  default = "kube-prometheus-stack"
}

variable "module_root" {
  type    = string
  default = "."
}

variable "repository_name" {
  type    = string
  default = "https://prometheus-community.github.io/helm-charts"
}

variable "namespace" {
  type    = string
  default = "md-monitoring"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "timeout" {
  type = number
  default = 600
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
