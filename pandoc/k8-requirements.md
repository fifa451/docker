<!--
## Template Instructions and Style Guide

* All items within tables are placeholder values: your review will fail if you include these values in your submission.

* Optionally delete any comments after reading and considering the information contained within them. 

* Code snippets should be avoided: no YAML/JSON objects

* Resources should all be capital starting and camel case: `myResourcename` is incorrect, but `MyResourceName` is correct.

* If a new resource is required to be added it is important to ensure that the values are representative of what is to be deployed.
 -->
---
# Purpose

This document is intended to provide an overview of the Kubernetes Resources and dependent/provider services that are being used by the *cs-web* application.

# Intended Audience

* DevOps
* Software Developers

---

# Dependent Services

The application service depends on the following services to run.

## Internal

Internal services detail items that this server role requires to run that are internal to the Kubernetes Cluster.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name               | Notes                                                                                                                |
| ------------------ | -------------------------------------------------------------------------------------------------------------------- |
| traefik-internal-0 | Incoming Http/Https requests, Traefik is an ingress provider which dynamically creates the AWS NLB, security groups. |

## External

External services detail items that this server role requires to run that are external to the Kubernetes Cluster.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name     | Notes             |
| -------- | ----------------- |
| do-mssql | External Database |
| ca-redis | Session store     |

# Provider Services

The application provides for the following applications/server roles.

## Internal

Internal services detail items that this server role provides services for that are internal to the Kubernetes Cluster.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name         | Notes                                                   |
| ------------ | ------------------------------------------------------- |
| cs-website   | The public front end (not yet extracted to own service) |
| cs-secureweb | Used to obtain customer transaction records             |

## External

External services detail items that this server role provides services for that are external to the Kubernetes Cluster.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name   | Notes                               |
| ------ | ----------------------------------- |
| lm-web | Service not yet migrated to cluster |
| hd-job | Hownd job server                    |

---
# Resources

**Format Notes**

* All resources should directly map to the Kubernetes Resource Kinds, Section headings should be human readable
* Notes can be used for more detailed commentary if required

# Namespaces

Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces.

| Name | Notes                  |
| ---- | ---------------------- |
| cs   | Credit Sense Namespace |

-----
# Config and Storage
-----

## ConfigMaps

ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name    | Namespace | Notes                      |
| ------- | --------- | -------------------------- |
| freetds | cs        | FreeTDS connection mapping |

## Secrets

A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name              | Namespace | Notes                                         |
| ----------------- | --------- | --------------------------------------------- |
| cs-web-env-secret | cs        | Application configuration Configuration files |

## PersistentVolume

A PersistentVolume (PV) is a piece of storage in the cluster that has been provisioned by an administrator. It is a resource in the cluster just like a node is a cluster resource.

<!--If not required please remove the table and use 'This Section is not required'  -->

| PersistentVolumeClaim | ReclaimPolicy | Type    | StorageClass | Size | Note                             |
| --------------------- | ------------- | ------- | ------------ | ---- | -------------------------------- |
| cs-web-documents      | Retain        | aws-efs | EFS          | N/A  | Storage for supporting documents |

## PersistentVolumeClaims

A PersistentVolumeClaim (PVC) is a request for storage by a user.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name   | Note                             |
| ------ | -------------------------------- |
| cs-web | Storage for supporting documents |

-----
# Workloads
-----

## Deployment

A Deployment controller provides declarative updates for Pods and ReplicaSets.

<!-- If not required please remove the table and use 'This Section is not required' -->
<!-- If not required please remove dependent health check table -->

| Name       | Containers by Image Name                         | HA/# | Ports | Notes                           |
| ---------- | ------------------------------------------------ | ---- | ----- | ------------------------------- |
| cs-web     | `nexus-ro-docker.creditsense.io/cs/cs-web:<tag>` | Y/3  | 80    | Application web server          |
| queHandler | `nexus-ro-docker.creditsense.io/cs/cs-web:<tag>` | Y/3  | N/A   | Runs the queHandler.php process |

### HealthCheck *Deployment Sub Section*

| Type           | Containers by Image Name                         | http/tcp | Port/Endpoint                 | failureThreshold | initialDelaySeconds | periodSeconds | successThreshold | timeoutSeconds |
| -------------- | ------------------------------------------------ | -------- | ----------------------------- | ---------------- | ------------------- | ------------- | ---------------- | -------------- |
| readinessProbe | `nexus-ro-docker.creditsense.io/cs/cs-web:<tag>` | http     | /healthcheck?method=readiness | 3                | 60                  | 30            | 1                | 3              |
| livenessProbe  | `nexus-ro-docker.creditsense.io/cs/cs-web:<tag>` | http     | /healthcheck                  | 3                | 10                  | 30            | 1                | 3              |

## DaemonSet

A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them.

- This Section is not required

<!-- If not required please remove the table and use 'This Section is not required' -->
<!-- If not required please remove dependent health check table -->

<!--
| Name | Containers by Image Name | Ports | Notes |
| ---- | ------------------------ | ----- | ----- |
|      |                          |       |       |
-->

### HealthCheck *DaemonSet Sub Section*

- This Section is not required

<!--
| Type | Containers by Image Name | http/tcp | Port/Endpoint | failureThreshold | initialDelaySeconds | periodSeconds | successThreshold | timeoutSeconds |
| ---- | ------------------------ | -------- | ------------- | ---------------- | ------------------- | ------------- | ---------------- | -------------- |
|      |                          | http     |               |                  |                     |               |                  |                |
|      |                          | http     |               |                  |                     |               |                  |                |
-->

## StatefulSet

StatefulSet is the workload API object used to manage stateful applications.

<!-- If not required please remove the table and use 'This Section is not required' -->
<!-- If not required please remove dependent health check table -->

- This Section is not required

-----
# Job Types
-----

## Job

A job creates one or more pods and ensures that a specified number of them successfully terminate.

<!--If not required please remove the table and use 'This Section is not required'  -->

- This Section is not required

## CronJob

A Cron Job creates Jobs on a time-based schedule.

<!--If not required please remove the table and use 'This Section is not required'  -->

*Notes* CronJob commands must be detailed in the application documentation

| Name           | Containers | schedule     | Notes                |
| -------------- | ---------- | ------------ | -------------------- |
| RemoveOldUsers | cs-web-php | * 5 * * *    | Remove Old Users     |
| ProcessReport  | cs-web-php | * * * * *    | Process any reports  |
| BankFormCheck  | cs-web-php | * 6,18 * * * | Check the Bank Forms |

Note: if running the "alpine" container jobs is not viable, we will need to make the "queHandler" cronjob into a separate "Deployment" to run the long-running "queHandler.php" process. This will not work as a k8s cronjob, as there is a maximum time that k8s cronjobs (and jobs) can run for.

-----
# Discovery and load balancing
-----

## Ingress

An API object that manages external access to the services in a cluster, typically HTTP.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name   | Ingress Class | TrafficType | Hosts              | Notes                                         |
| ------ | ------------- | ----------- | ------------------ | --------------------------------------------- |
| cs-web | traefik       | internal-0  | creditsense.com.au | Links deployment to traefik ingress provider. |
| cs-web | traefik       | external-0  | creditsense.com.au | Links deployment to traefik ingress provider. |

## Service

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name   | Type      | Port | Notes              |
| ------ | --------- | ---- | ------------------ |
| cs-web | ClusterIP | 80   | Deployment service |

-----
# High Availablity Configuration
-----

## PodDisruptionBudget

A PDB limits the number of pods of a replicated application that are down simultaneously from voluntary disruptions.

<!--If not required please remove the table and use 'This Section is not required'  -->

| Name   | DisruptionsAllowed | Notes                                    |
| ------ | ------------------ | ---------------------------------------- |
| cs-web | 1                  | Only Allow one to be removed at any time |

## HorizontalPodAutoscaler

The Horizontal Pod Autoscaler automatically scales the number of pods.

- This Section will be completed in Story 5 of 5.

<!--If not required please remove the table and use 'This Section is not required'  -->

<!--
| Name   | MaxReplicas | MinReplicas | Type | Metric | Notes |
| ------ | ----------- | ----------- | ---- | ------ | ----- |
| cs-web | 15          | 3           | CPU  | 50     |       |
-->

-----
# RBAC
-----

## ServiceAccount

In Kubernetes, service accounts are used to provide an identity for pods.

<!--If not required please remove the table and use 'This Section is not required'  -->

- This Section is not required

<!--
| Name | Notes |
| ---- | ----- |
|      |       |
-->

## ClusterRole

A role that provides access across namespaces.

<!-- If not required please remove the table and use 'This Section is not required'  -->

- This Section is not required

<!--
| Name | Resources | Action | Notes |
| ---- | --------- | ------ | ----- |
|      |           |        |       |
|      |           |        |       |
-->

## ClusterRoleBinding

Binds a cluster role to a service account.

<!--If not required please remove the table and use 'This Section is not required'  -->

- This Section is not required

<!--
| Name | Binding Cluster Role | Binding Service Account | Notes |
| ---- | -------------------- | ----------------------- | ----- |
|      |                      |                         |       |
-->

## Role

A role that provides access within a namespaces.

<!--If not required please remove the table and use 'This Section is not required'  -->

- This Section is not required

<!--
| Name | Resources | Action | Notes |
| ---- | --------- | ------ | ----- |
|      |           |        |       |
-->

## RoleBinding

Binds a role to a service account.

<!--If not required please remove the table and use 'This Section is not required'  -->

- This Section is not required

<!--
| Name | Binding Role | Binding Subject | Notes |
| ---- | ------------ | --------------- | ----- |
|      |              |                 |       |
-->

-----
# Custom Resources
-----

* Custom resources are used to define resources that have been added to the cluster for example KubeDB.

The following [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) are required.

Custom Resources should follow the format for Kubernetes kinds as above.

## Custom Resources Definitions

| Name           | Definition (config file)                                     | Notes                                                     |
| -------------- | ------------------------------------------------------------ | --------------------------------------------------------- |
| Alertmanager   | 0prometheus-operator-0alertmanagerCustomResourceDefinition   | Alert Manager config see docs/alerting                    |
| Prometheus     | 0prometheus-operator-0prometheusCustomResourceDefinition     | Prometheus server docs/crd                                |
| PrometheusRule | 0prometheus-operator-0prometheusruleCustomResourceDefinition | Create prometheus rules docs/crd                          |
| ServiceMonitor | 0prometheus-operator-0servicemonitorCustomResourceDefinition | Create service targets for prometheus to monitor docs/crd |

## Custom Resource

Custom resources used by this server rolefc

| Name                    | Resource Type  | Notes                                    |
| ----------------------- | -------------- | ---------------------------------------- |
| prometheus-operator     | ServiceMonitor | Metrics endpoint for prometheus          |
| alert-manager           | ServiceMonitor | Metrics endpoint for alert manager       |
| main                    | Alertmanager   | Alert manager for creating alerts        |
| grafana                 | ServiceMonitor | Metrics endpoint for grafana             |
| node-exporter           | ServiceMonitor | Metrics endpoint for node-exporter       |
| kube-state-metrics      | ServiceMonitor | Metrics endpoint for kube-state-metrics  |
| prometheus              | Prometheus     | Deploys prometheus service               |
| prometheus-rules        | PrometheusRule | Deploys base prometheus rules            |
| prometheus              | ServiceMonitor | Who watches the watcher                  |
| kube-apiserver          | ServiceMonitor | Monitor kube api                         |
| coredns                 | ServiceMonitor | Monitor coredns                          |
| kube-controller-manager | ServiceMonitor | Monitor kubernetes controller            |
| kubelet                 | ServiceMonitor | Monitor kubernetes applications on nodes |
| kube-scheduler          | ServiceMonitor | Monitor the scheduler                    |
