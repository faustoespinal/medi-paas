
resource "helm_release" "test_apps" {
  name       = "${var.release_name}"

  repository = var.repository_name
  chart      = "${var.module_root}/charts/test-apps"
  description = "setup helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace
}
