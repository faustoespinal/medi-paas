# medi-paas
Medical applications open-source PaaS runtime deployable on kubernetes.

### 100% Terraform script to standup + custom Jobs to configure/initialize 
```
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
```

### Setup and Deletion
```
terraform init
terraform plan -var-file=./environments/dev/dev.tfvars.json
terraform apply -auto-approve -var-file=./environments/dev/dev.tfvars.json
terraform destroy -auto-approve
```


### Sample hosts file to work in non-DNS environments
```
192.168.2.242   keycloak keycloak.karofa
192.168.2.242   logging logging.karofa
192.168.2.242   monitoring monitoring.karofa
192.168.2.242   ohifviewer ohifviewer.karofa
192.168.2.242   orthanc orthanc.karofa
192.168.2.242   postgres-console postgres-console.karofa
192.168.2.242   test-apps-istio test-apps-istio.karofa
192.168.2.242   test-apps-no-istio test-apps-no-istio.karofa

```

