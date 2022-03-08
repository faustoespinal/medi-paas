terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.13.1"
    }
  }
  required_version = "~> 1.0.11"
}

