provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.kube_context
}

# data "terraform_remote_state" "medpaas" {
#   backend = "local"
#   config = {
#     path = "~/.medpaas/terraform.tfstate"
#   }
# }

provider "kubectl" {
  # Configuration options
}