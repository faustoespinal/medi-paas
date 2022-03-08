resource "kubernetes_namespace" "opa_istio" {
  metadata {
    name = "opa-istio"
  }
}

resource "helm_release" "opa_envoy" {
  name       = "${var.release_name}"

  repository = var.repository_name
  chart      = "${var.module_root}/charts/opa-envoy"
  description = "setup helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  depends_on = [    kubernetes_namespace.opa_istio,  ]
}
