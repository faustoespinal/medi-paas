resource "helm_release" "postgres_operator" {
  name       = var.release_name

  repository = "${var.repository_base}/postgres-operator"
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_file_path)}"
  ]
}

resource "helm_release" "postgres_operatorui" {
  name       = "${var.release_name}-ui"

  repository = "${var.repository_base}/postgres-operator-ui"
  chart      = "${var.chart_name}-ui"
  description = "${var.chart_name}-ui helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_file_path)}"
  ]
  depends_on = [    helm_release.postgres_operator,  ]
}

