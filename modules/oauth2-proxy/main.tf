
resource "helm_release" "oauth2_proxy" {
  name       = var.oauth_clients.name[count.index]
  count      = "${length(var.oauth_clients.name)}"

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  timeout = var.timeout

  values = [
    "${templatefile("${var.module_root}/oauth2-proxy-values.tftpl", {clientId=var.oauth_clients.name[count.index], clientSecret=var.oauth_clients.secret[count.index], redirect_url=var.oauth_clients.redirect_url[count.index], upstreams=var.oauth_clients.upstreams[count.index]})}"
  ]
}


