
# resource "kubernetes_namespace" "istio_ingress" {
#   metadata {
#     labels = {
#       istio-injection="enabled"
#     }
#     name = "istio-ingress"
#   }
# }

resource "helm_release" "istio_ingress" {
  name       = "istio-ingress"

  repository = var.repository_name
  chart      = "${var.chart_name}"
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_file_path)}"
  ]
}

