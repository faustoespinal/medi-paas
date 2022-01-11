
resource "helm_release" "keycloak" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  timeout = var.timeout

  values = [
    "${file(var.values_file_path)}"
  ]
}

resource "helm_release" "setup-keycloak" {
  name       = "setup-${var.release_name}"

  repository = var.repository_name
  chart      = "${var.module_root}/charts/setup-keycloak"
  description = "setup helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  depends_on = [    helm_release.keycloak,  ]
}

