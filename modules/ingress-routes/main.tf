
resource "helm_release" "istio_ingress_routes" {
  name       = "${var.release_name}"

  repository = var.repository_name
  chart      = "${var.module_root}/charts/istio-ingress-routes"
  description = "Setup helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_file_path)}"
   ]
}
