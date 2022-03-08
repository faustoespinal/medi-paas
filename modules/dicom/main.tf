
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

resource "helm_release" "orthanc" {
  name       = "${var.module_name}-db"

  chart      = "${var.module_root}/charts/orthanc"
  description = "Orthanc helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_orthanc_file_path)}"
  ]
  depends_on = [    kubernetes_config_map_v1.opa_policy, kubernetes_config_map_v1.opa_istio_config,  ]
}

# resource "helm_release" "ohif_viewer" {
#   name       = "${var.module_name}-viewer"

#   chart      = "${var.module_root}/charts/ohif-viewer"
#   description = "OHIF viewer helm chart installed by ${var.release_creator}"
#   create_namespace = var.create_namespace
#   namespace = var.namespace

#   values = [
#     "${file(var.values_ohif_file_path)}"
#   ]
#   depends_on = [    helm_release.orthanc,  ]
# }

