# medi-paas
Medical applications open-source PaaS runtime deployable on kubernetes.

### 100% Terraform script to standup + custom Jobs to configure/initialize 
    * Prometheus (telemetry) --
    * Loki (logs)
    * MetalLB --
    * Kafka --
    * Redis --
    * OPA (Authorization)
    * Keycloak vs Dex (IaM) --
    * Hashicorp Vault (Secrets management and CA, database secrets injection)
    * cert-manager --
    * Istio (Service Mesh and API gateway)
    * Falco (Threat detection monitor)
    * Kyverno (k8s resource policy management: mutate resources, reject, etc...)
    * Postgres or similar
    * Velero (Backup/restore)
    * Orthanc
    * OHIF Dicom Viewer, Papaya, 
    * Minio
    * HAPI Fhir

    * kubewatch (Triggers based on kubernetes events....)

### Setup and Deletion
terraform init
terraform plan -var-file=./dev.tfvars.json
terraform apply -auto-approve -var-file=./dev.tfvars.json
terraform destroy -auto-approve

