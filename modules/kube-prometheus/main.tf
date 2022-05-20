
resource "helm_release" "prometheus" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  timeout = var.timeout

  values = [
    "${templatefile("${var.module_root}/values-prometheus.tftpl", {clientId="monitoring", clientSecret="elmonitoreosecreto543210secretos", hosts=var.host_aliases.hosts, ips=var.host_aliases.ips})}"
  ]
}

resource "helm_release" "config-prometheus" {
  name       = "config-${var.release_name}"

  repository = var.repository_name
  chart      = "${var.module_root}/charts/config-prometheus"
  description = "configuration helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  depends_on = [    helm_release.prometheus,  ]
}


