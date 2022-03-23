
resource "helm_release" "orthanc" {
  name       = "${var.module_name}-db"

  chart      = "${var.module_root}/charts/orthanc"
  description = "Orthanc helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_orthanc_file_path)}"
  ]
}

resource "helm_release" "ohif_viewer" {
  name       = "ohif-viewer"

  chart      = "${var.module_root}/charts/ohif-viewer"
  description = "OHIF viewer helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_ohif_file_path)}"
  ]
  depends_on = [    helm_release.orthanc,  ]
}

