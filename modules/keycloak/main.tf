
resource "helm_release" "keycloak" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  version    = "7.1.18"
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  timeout = var.timeout

  values = [
    "${file(var.values_file_path)}"
  ]
}

# resource "helm_release" "setup-keycloak" {
#   name       = "setup-${var.release_name}"

#   repository = var.repository_name
#   chart      = "${var.module_root}/charts/setup-keycloak"
#   description = "setup helm chart installed by ${var.release_creator}"
#   create_namespace = var.create_namespace
#   namespace = var.namespace
#   values = [
#     "${templatefile("${var.module_root}/setup-keycloak-values.tftpl", {client_ids=var.oauth_clients.name, client_secrets=var.oauth_clients.secret, redirect_urls=var.oauth_clients.redirect_url})}"
#   ]

#   depends_on = [    helm_release.keycloak,  ]
# }

# This helm chart points to the keycloak terraform provider chart
resource "helm_release" "setup-keycloak" {
  name       = "setup-${var.release_name}"

  repository = var.repository_name
  chart      = "${var.module_root}/charts/setup-keycloak-tf"
  description = "setup helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  depends_on = [    helm_release.keycloak,  ]
}

