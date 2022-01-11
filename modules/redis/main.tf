
resource "helm_release" "redis" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_file_path)}"
  ]
}

