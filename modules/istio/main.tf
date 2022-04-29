
resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

resource "helm_release" "istio_base" {
  name       = "istio-base"

  repository = var.repository_name
  chart      = "base"
  description = "${var.chart_name}-base helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  wait = true

  depends_on = [    kubernetes_namespace.istio_system,  ]
}

resource "helm_release" "istiod" {
  name       = "istiod"

  repository = var.repository_name
  chart      = "istiod"
  description = "${var.chart_name}d helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  wait = true

  values = [
    "${templatefile("${var.module_root}/istiod-values.tftpl", { client_ids=var.oauth_clients.name, authz=var.oauth_clients.authz, organization_name="cedimat" })}"
  ]
  depends_on = [    helm_release.istio_base,  ]
}

