
resource "kubernetes_namespace" "md-logging" {
  metadata {
    name = "md-logging"
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "kubernetes_namespace" "md-monitoring" {
  metadata {
    name = "md-monitoring"
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "kubernetes_namespace" "md-messaging" {
  metadata {
    labels = {
      mdmonitor = "enabled"
      istio-injection = "enabled"
    }
    name = "md-messaging"
  }
}

# 262 928 5900
resource "kubernetes_namespace" "md-storage" {
  metadata {
    labels = {
      mdmonitor = "enabled"
      istio-injection = "enabled"
    }
    name = "md-storage"
  }
}

resource "kubernetes_namespace" "postgres-operator" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }
    name = "postgres-operator"
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

resource "kubernetes_namespace" "md-dicom" {
  metadata {
    labels = {
      mdmonitor = "enabled"
      istio-injection = "enabled"
    }
    name = "md-dicom"
  }
}

module "istio" {
  source = "./modules/istio"
  count = var.istio_count

  release_name = "istio"
  create_namespace = var.create_namespace
  module_root = "./modules/istio"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/istio/values.yaml"
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

module "logging" {
  source = "./modules/logging"
  count = var.logging_count

  release_name = "md-logging"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/logging/values.yaml"
  depends_on = [ module.istio ]
}

module "prometheus" {
  source = "./modules/kube-prometheus"
  count = var.prometheus_count

  release_name = "md-prometheus"
  create_namespace = var.create_namespace
  module_root = "./modules/kube-prometheus"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/kube-prometheus/values.yaml"
  depends_on = [ module.cert_manager ]
}

module "gateway" {
  source = "./modules/gateway"
  count = var.gateway_count

  release_name = "md-gateway"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/gateway/values.yaml"
  depends_on = [ module.cert_manager ]
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
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/redis/values.yaml"
  depends_on = [ module.gateway ]
}

module "kafka" {
  source = "./modules/kafka"
  count = var.kafka_count

  release_name = "md-kafka"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/kafka/values.yaml"
  depends_on = [ module.gateway ]
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
  values_file_path = "${var.system_profile_root}/keycloak/values.yaml"
  depends_on = [
    module.cert_manager,
  ]
}

module "dicom" {
  source = "./modules/dicom"
  count = var.dicom_count

  create_namespace = var.create_namespace
  module_root = "./modules/dicom"
  release_creator = var.release_creator
  values_orthanc_file_path = "${var.system_profile_root}/dicom/values-orthanc.yaml"
  values_ohif_file_path = "${var.system_profile_root}/dicom/values-ohif.yaml"
  depends_on = [ module.postgres_operator ]
}

module "istio_ingress" {
  source = "./modules/istio-ingress"
  count = var.istioingress_count

  release_name = "istio-ingress"
  create_namespace = var.create_namespace
  module_root = "./modules/istio-ingress"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/istio-ingress/values.yaml"
  depends_on = [ module.dicom ]
}

