
resource "helm_release" "loki" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${templatefile("${var.module_root}/values-logging.tftpl", {clientId="logging", clientSecret="ellogeosecretos876543210secretos", hosts=var.host_aliases.hosts, ips=var.host_aliases.ips})}"
  ]
}

