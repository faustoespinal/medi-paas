
# opa-envoy-setup

## Overview
Deploys the OPA-envoy policy and configurations necessary for a namespace to be under its ownership

## Prerequisites
- Kubernetes 1.12+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart
To install the chart with the release name "my-release":

```bash
$ helm install my-opa-envoy-setup <path>/opa-envoy-setup
```

The command deploys opa-envoy-setup on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using "helm list"

## Uninstalling the Chart
To uninstall/delete the "my-opa-envoy-setup" deployment:

```bash
$ helm delete my-opa-envoy-setup
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

Specify each parameter using the "--set key=value[,key=value]" argument to "helm install". For example,

```bash
$ helm install my-opa-envoy-setup --set opa-envoy-setup.key="thevalue" <path>/opa-envoy-setup
```

The above command sets the release opa-envoy-setup helm chart value opa-envoy-setup.key to "thevalue".

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-opa-envoy-setup -f values.yaml <path>/opa-envoy-setup
```

