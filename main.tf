
resource "kubernetes_namespace" "istio-inject-ns" {
  count=length(var.istio_namespaces)
  metadata {
    name = var.istio_namespaces[count.index]
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "kubernetes_namespace" "org-istio-inject-ns" {
  count=length(var.org_namespaces)
  metadata {
    name = var.org_namespaces[count.index]
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "kubernetes_namespace" "opa-istio-inject-ns" {
  count=length(var.opa_istio_namespaces)
  metadata {
    name = var.opa_istio_namespaces[count.index]
    labels = {
      mdmonitor = "enabled"
      istio-injection = "enabled"
      opa-istio-injection="enabled"
    }
  }
}

resource "kubernetes_namespace" "md-security" {
  metadata {
    labels = {
      mdmonitor = "enabled"
      istio-injection = "enabled"
    }
    name = "md-security"
  }
}

module "istio" {
  source = "./modules/istio"
  count = var.istio_count

  release_name = "istio"
  create_namespace = var.create_namespace
  module_root = "./modules/istio"
  release_creator = var.release_creator
  oauth_clients = var.oauth_clients
}

module "cert_manager" {
  source = "./modules/cert-manager"
  count = var.certmanager_count

  release_name = "md-cert-manager"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  encryption_algorithm = var.cert_encryption_algorithm
  encryption_size = var.cert_encryption_size
  encryption_encoding = var.cert_encryption_encoding
  values_file_path = "${var.system_profile_root}/cert-manager/values.yaml"
  depends_on = [ module.istio ]
}

module "opa_envoy" {
  source = "./modules/opa-envoy"
  count = var.opaenvoy_count

  release_name = "opa-envoy"
  create_namespace = var.create_namespace
  module_root = "./modules/opa-envoy"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/opa-envoy/values.yaml"
  depends_on = [ module.cert_manager ]
}

# Configure all OPA-envoy namespaces with same default settings.
resource "helm_release" "opa-envoy-setup" {
  name  = "opa-envoy-setup"
  count = length(var.opa_istio_namespaces)

  repository = "opa-envoy-setup"
  chart      = "./charts/opa-envoy-setup"
  description = "OPA-Envoy configuration helm chart installed by ${var.release_creator}"
  create_namespace = var.create_namespace
  namespace = var.opa_istio_namespaces[count.index]
  depends_on = [ module.opa_envoy ]
}

module "test_apps" {
  source = "./modules/test-apps"
  count = length(var.namespace_types)

  release_name = "test-apps-${var.namespace_types[count.index]}"
  create_namespace = var.create_namespace
  module_root = "./modules/test-apps"
  release_creator = var.release_creator
  namespace="test-apps-${var.namespace_types[count.index]}"
  values_file_path = "${var.system_profile_root}/test-apps/values.yaml"
  depends_on = [ helm_release.opa-envoy-setup, module.gateway ]
}

module "logging" {
  source = "./modules/logging"
  count = var.logging_count

  release_name = "md-logging"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/logging/values.yaml"
  depends_on = [ module.opa_envoy ]
}

module "prometheus" {
  source = "./modules/kube-prometheus"
  count = var.prometheus_count

  release_name = "md-prometheus"
  create_namespace = var.create_namespace
  module_root = "./modules/kube-prometheus"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/kube-prometheus/values.yaml"
  depends_on = [ module.opa_envoy ]
}

module "gateway" {
  source = "./modules/gateway"
  count = var.gateway_count

  release_name = "md-gateway"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/gateway/values.yaml"
  depends_on = [ module.opa_envoy ]
}

module "postgres_operator" {
  source = "./modules/postgres-operator"
  count = var.postgres_operator_count

  release_name = "postgres-operator"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/postgres-operator/values.yaml"
  depends_on = [ module.gateway ]
}

module "redis" {
  source = "./modules/redis"
  count = var.redis_count

  release_name = "md-redis"
  create_namespace = var.create_namespace
  module_root = "./modules/redis"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/redis/values.yaml"
  depends_on = [ helm_release.opa-envoy-setup, module.gateway ]
}

module "kafka" {
  source = "./modules/kafka"
  count = var.kafka_count

  release_name = "md-kafka"
  create_namespace = var.create_namespace
  module_root = "./modules/kafka"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/kafka/values.yaml"
  depends_on = [ helm_release.opa-envoy-setup, module.gateway ]
}

module "keycloak" {
  source = "./modules/keycloak"
  count = var.keycloak_count

  release_name = "md-keycloak"
  create_namespace = var.create_namespace
  module_root = "./modules/keycloak"
  release_creator = var.release_creator
  encryption_algorithm = var.cert_encryption_algorithm
  encryption_size = var.cert_encryption_size
  encryption_encoding = var.cert_encryption_encoding
  oauth_clients = var.oauth_clients
  values_file_path = "${var.system_profile_root}/keycloak/values.yaml"
  depends_on = [
    module.opa_envoy,
  ]
}

# Configure all OPA-envoy namespaces with same default settings.
module "oauth2-proxy" {
  source = "./modules/oauth2-proxy"
  count = length(var.org_namespaces)

  create_namespace = var.create_namespace
  module_root = "./modules/oauth2-proxy"
  release_creator = var.release_creator
  namespace="${var.org_namespaces[count.index]}"
  oauth_clients = var.oauth_clients
  depends_on = [ module.keycloak, module.redis ]
}

module "dicom" {
  source = "./modules/dicom"
  count = var.dicom_count

  create_namespace = var.create_namespace
  module_root = "./modules/dicom"
  release_creator = var.release_creator
  values_orthanc_file_path = "${var.system_profile_root}/dicom/values-orthanc.yaml"
  values_ohif_file_path = "${var.system_profile_root}/dicom/values-ohif.yaml"
  values_load_dicom_path = "${var.system_profile_root}/dicom/values-load-dicom.yaml"
  depends_on = [ helm_release.opa-envoy-setup, module.postgres_operator ]
}

module "istio_ingress" {
  source = "./modules/istio-ingress"
  count = var.istioingress_count

  release_name = "istio-ingress"
  create_namespace = var.create_namespace
  module_root = "./modules/istio-ingress"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/istio-ingress/values.yaml"
  depends_on = [ module.gateway ]
}

module "ingress_routes" {
  source = "./modules/ingress-routes"
  # If istio_ingress is not deployed, then this is not deployed also
  count = var.istioingress_count

  release_name = "istio-ingress-routes"
  create_namespace = var.create_namespace
  module_root = "./modules/ingress-routes"
  release_creator = var.release_creator
  oauth_clients = var.oauth_clients
  values_file_path = "${var.system_profile_root}/ingress-routes/values.yaml"
  depends_on = [ module.istio_ingress ]
}
