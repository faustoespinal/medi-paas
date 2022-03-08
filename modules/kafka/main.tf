
resource "kubernetes_config_map_v1" "opa_istio_config" {
  metadata {
    name = "opa-istio-config"
    namespace = var.namespace
  }

  data = {
    "config.yaml" = "${file("${var.module_root}/opa-istio-config.yaml")}"
  }
}

resource "kubernetes_config_map_v1" "opa_policy" {
  metadata {
    name = "opa-policy"
    namespace = var.namespace
  }

  data = {
    "policy.rego" = "${file("${var.module_root}/policy.rego")}"
  }
}

resource "helm_release" "kafka" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
  timeout = var.timeout

  values = [
    "${file(var.values_file_path)}"
  ]
  depends_on = [    kubernetes_config_map_v1.opa_policy, kubernetes_config_map_v1.opa_istio_config,  ]
}

