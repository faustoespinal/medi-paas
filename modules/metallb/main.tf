
resource "kubernetes_namespace" "metallb" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "metallb" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file("${var.module_root}/values.yaml")}"
  ]

  depends_on = [    kubernetes_namespace.metallb,  ]
}

resource "helm_release" "setup-metallb" {
  name       = "setup-${var.release_name}"

  repository = var.repository_name
  chart      = "${var.module_root}/charts/setup-metallb"
  description = "setup-metallb helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  depends_on = [    helm_release.metallb,  ]
}

