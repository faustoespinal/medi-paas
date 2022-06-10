locals {
  oauth_clients = distinct(flatten([
      for client in var.clients : {
        client_name = client.name
        client_secret = client.secret
        redirect_url= client.redirect_url
        upstreams= client.upstreams
      } if client.authz
    ]
  ))
}

resource "helm_release" "oauth2_proxy" {
  for_each      = { for entry in local.oauth_clients: "${var.namespace}.${entry.client_name}" => entry }

  name       = each.value.client_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  timeout = var.timeout

  values = [
    "${templatefile("${var.module_root}/oauth2-proxy-values.tftpl", {clientId=each.value.client_name, clientSecret=each.value.client_secret, redirect_url=each.value.redirect_url, upstreams=each.value.upstreams})}"
  ]
}


