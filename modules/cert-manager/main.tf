terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.13.1"
    }
  }
  #required_version = "~> 1.0.11"
}

resource "tls_private_key" "karofa_ca" {
  algorithm = "${var.encryption_algorithm}"
  ecdsa_curve = "P384"
}

resource "tls_cert_request" "karofa_csr" {
  key_algorithm   = "${var.encryption_algorithm}"
  private_key_pem = "${tls_private_key.karofa_ca.private_key_pem}"

  subject {
    common_name  = "${var.namespace}"
    organization = "Medi PaaS certificate"
  }
}

resource "tls_self_signed_cert" "karofa_ss_cert" {
  key_algorithm   = "${var.encryption_algorithm}"
  private_key_pem = "${tls_private_key.karofa_ca.private_key_pem}"

  subject {
    common_name  = "${var.namespace}"
    organization = "Medi PaaS certificate"
  }

  validity_period_hours = 2160
  is_ca_certificate = true

  allowed_uses = [
    "key_encipherment",
    "cert_signing",
  ]
}

resource "tls_locally_signed_cert" "karofa_cert" {
  cert_request_pem   = "${tls_cert_request.karofa_csr.cert_request_pem}"
  ca_key_algorithm   = "${var.encryption_algorithm}"
  ca_private_key_pem = "${tls_private_key.karofa_ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.karofa_ss_cert.cert_pem}"

  validity_period_hours = 2160
  is_ca_certificate = true

  allowed_uses = [
    "key_encipherment",
    "cert_signing",
  ]
}

resource "helm_release" "cert_manager" {
  name       = var.release_name

  repository = var.repository_name
  chart      = var.chart_name
  description = "${var.chart_name} helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.namespace

  values = [
    "${file(var.values_file_path)}"
  ]
  depends_on = [    tls_locally_signed_cert.karofa_cert,  ]
}

resource "kubernetes_secret" "issuer_certs" {
  metadata {
    name = "ca-key-pair"
    namespace = var.namespace
  }

  data = {
    "tls.crt" = "${tls_locally_signed_cert.karofa_cert.cert_pem}"
    "tls.key" = "${tls_private_key.karofa_ca.private_key_pem}"
  }
  depends_on = [    helm_release.cert_manager,  ]
}

resource "kubectl_manifest" "ca_issuer" {
  yaml_body  = <<-EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ca-issuer
spec:
  ca:
    secretName: ca-key-pair
EOF
  depends_on = [    kubernetes_secret.issuer_certs,  ]
}

