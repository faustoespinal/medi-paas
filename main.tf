
resource "kubernetes_namespace" "md-messaging" {
  metadata {
    labels = {
      mdmonitor = "enabled"
    }
    name = "md-messaging"
  }
}

resource "kubernetes_namespace" "md-storage" {
  metadata {
    labels = {
      mdmonitor = "enabled"
    }
    name = "md-storage"
  }
}

resource "kubernetes_namespace" "md-security" {
  metadata {
    labels = {
      mdmonitor = "enabled"
    }
    name = "md-security"
  }
}

resource "kubernetes_namespace" "md-dicom" {
  metadata {
    labels = {
      mdmonitor = "enabled"
    }
    name = "md-dicom"
  }
}

module "prometheus" {
  source = "./modules/kube-prometheus"

  release_name = "md-prometheus"
  create_namespace = var.create_namespace
  module_root = "./modules/kube-prometheus"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/kube-prometheus/values.yaml"
}

module "redis" {
  source = "./modules/redis"

  release_name = "md-redis"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/redis/values.yaml"
}

module "gateway" {
  source = "./modules/gateway"

  release_name = "md-gateway"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/gateway/values.yaml"
}

module "logging" {
  source = "./modules/logging"

  release_name = "md-logging"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/logging/values.yaml"
}

module "kafka" {
  source = "./modules/kafka"

  release_name = "md-kafka"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/kafka/values.yaml"
}

module "cert_manager" {
  source = "./modules/cert-manager"

  release_name = "md-cert-manager"
  create_namespace = var.create_namespace
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/cert-manager/values.yaml"
}

module "keycloak" {
  source = "./modules/keycloak"

  release_name = "md-keycloak"
  create_namespace = var.create_namespace
  module_root = "./modules/keycloak"
  release_creator = var.release_creator
  values_file_path = "${var.system_profile_root}/keycloak/values.yaml"
}

module "dicom" {
  source = "./modules/dicom"

  create_namespace = var.create_namespace
  module_root = "./modules/dicom"
  release_creator = var.release_creator
  values_orthanc_file_path = "${var.system_profile_root}/dicom/values-orthanc.yaml"
  values_ohif_file_path = "${var.system_profile_root}/dicom/values-ohif.yaml"
}

