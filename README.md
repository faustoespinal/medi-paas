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

Send pdf to Philips@reedgroup.com

* Create environment of learning and innovation within S&SD team
  - Attend at least one conference per year and share learnings with wider S&SD team
  - Hold regular on-on-ones with S&SD architects to socialize knowledge and trends on the wider SW industry
  - Participate in the celebrations of team successes and give out at least 2 recognition recommendations per year.

* Create U/S ecosystem architecture blueprint
  - Drive beyond the Ultrasound device a services & solutions ecosystem and connectivity to the bigger PD and Philips ecosystem. Partner with PD, PSSD and the SCDS (CTO-MT) teams. 
  - Identify core ecosystem managed services running on top of HSDP

  ----- Work with U/S R&D to achieve SW transformation (GO BEYOND JUST SSD)

* Drive U/S connectivity initiative
    - Design to ensure driving up device connectivity
    - Align efforts with SCDS initiative
    - Work with Quicksilver/Rhythm teams to ensure appropiate connectivity design is built into core platform
    - Drive Remote SW management as an end to end solution across our NPI's.  Drive improvements to our managed infrastructure needed to support storage and transmission of SW updates.

* Drive U/S collaboration with with wider Philips and PD to adopt SaaS Factory initiatives
  - Work with wider PD/Philips architects and product owners to define prioritized requirements for U/S SaaS offerings.
    - Lay out a clear picture of sourcing for the needed SaaS services.  What things will U/S own vs which we can leverage from wider PD and/or Philips
    - In collaboration with EDI create blueprint for Philips marketplace and licensing adoption

* Collaborate with S&SD Solutions and Services product management to create roadmap of offerings to help customers understand
  - Help define roadmap of SaaS product offerings and transform solutions within S&SD to be greater than 25% of revenue.
  - Enable priority SaaS products such as Collaboration Live and TTZ and ensure alignment with future U/S ecosystem foundations



Integrate CL into Radiology Workflow IVP. Champion and drive “Connected Ultrasound” IVP end-to-end in partnership with categories.







