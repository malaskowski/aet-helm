# AET Helm chart
![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.3.0](https://img.shields.io/badge/AppVersion-3.3.0-informational?style=flat-square)

<p align="center">
  <img src="https://raw.githubusercontent.com/malaskowski/aet-helm/main/misc/aet-helm.png" alt="AET Helm Logo"/>
</p>

This chart bootstraps an [AET](https://github.com/wttech/aet) deployment on a [Kubernetes](http://kubernetes.io/) cluster using the [Helm](https://helm.sh/) package manager.

[AET](https://github.com/wttech/aet) is a system that detects visual changes on web sites and performs basic page health checks.

## TL;DR
```
helm repo add aet-chart https://malaskowski.github.io/aet-helm
helm install --set ingress.enabled=true my-aet aet-chart/aet -n aet --create-namespace
```

## Prerequisites
- Kubernetes cluster with at least 8 GB ram and 2 CPU to run basic AET configuration
- Helm 3.6+
- Add Helm repository with `helm repo add aet-chart https://malaskowski.github.io/aet-helm`

## Installing the Chart
To instal the chart with the release name `my-aet` using existing domain that points to your Kubernetes cluster, run:
```
helm install --set ingress.enabled=true --set ingress.host=my-aet-domain.com my-aet aet-chart/aet -n aet --create-namespace
```

This command deploys AET on Kubernetes cluster with the default configuration using `aet` namespace.
The [Parameters](#parameters) section lists the parameters that can be configured.

> Tip: If you wish to run AET on local k8s cluster (e.g. Docker Desktop) you may want to use default provided Ingress.
> In that case run:
> ```
> helm install --set ingress.enabled=true local aet-chart/aet -n aet --create-namespace
> ```
>
> Your AET instance domain should be `http://aet-127.0.0.1.nip.io/`.
>
> You may use `watch -n 1 kubectl get all,ingress --namespace aet` command to watch progress of your instance setup.
> When all pods are in state `Running` you may start using your instance (it usually takes about 2-3 minutes from the start).

## Uninstalling the Chart
To uninstall/delete the my-aet deployment:
```
helm uninstall my-aet -n aet
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.image.repository | string | `"skejven/aet_activemq"` | image repository for ActiveMQ |
| activemq.image.tag | string | `nil` | ActiveMQ image tag, overrides `aetDockerTag` |
| activemq.livenessProbe.enabled | bool | `true` | enables ActiveMQ pods liveness probe |
| activemq.livenessProbe.failureThreshold | int | `6` |  |
| activemq.livenessProbe.initialDelaySeconds | int | `120` |  |
| activemq.livenessProbe.periodSeconds | int | `30` |  |
| activemq.livenessProbe.successThreshold | int | `1` |  |
| activemq.livenessProbe.timeoutSeconds | int | `5` |  |
| activemq.ports.adminPanelPort | int | `8161` | Port ActiveMQ admin panel will be exposed at |
| activemq.ports.brokerServicePort | int | `61616` | Port at which ActiveMQ exposes its broker service |
| activemq.ports.jmxPort | int | `11199` | Port at which ActiveMQ exposes JMX that is used to purge queues |
| activemq.readinessProbe.enabled | bool | `true` | enables ActiveMQ pods readiness probe |
| activemq.readinessProbe.failureThreshold | int | `6` |  |
| activemq.readinessProbe.initialDelaySeconds | int | `60` |  |
| activemq.readinessProbe.periodSeconds | int | `10` |  |
| activemq.readinessProbe.successThreshold | int | `1` |  |
| activemq.readinessProbe.timeoutSeconds | int | `5` |  |
| activemq.resources.limits.cpu | string | `"150m"` | ActiveMQ limits cpu resources |
| activemq.resources.limits.memory | string | `"150Mi"` | ActiveMQ limits memory resources |
| activemq.resources.requests.cpu | string | `"100m"` | ActiveMQ request cpu resources |
| activemq.resources.requests.memory | string | `"120Mi"` | ActiveMQ request memory resources |
| aetDockerTag | string | `"0.14.0"` | default version of AET images used to run the instance |
| browsermob.image.repository | string | `"skejven/aet_browsermob"` | image repository for Browsermob Proxy |
| browsermob.image.tag | string | `nil` | Browsermob image tag, overrides `aetDockerTag` |
| browsermob.livenessProbe.enabled | bool | `true` | enables Browsermob pods liveness probe |
| browsermob.livenessProbe.failureThreshold | int | `6` |  |
| browsermob.livenessProbe.initialDelaySeconds | int | `60` |  |
| browsermob.livenessProbe.periodSeconds | int | `30` |  |
| browsermob.livenessProbe.successThreshold | int | `1` |  |
| browsermob.livenessProbe.timeoutSeconds | int | `5` |  |
| browsermob.ports.apiPort | int | `8080` | Port with Browsermob API exposed |
| browsermob.proxyBasePort | int | `8281` | Base port for the proxy range to start |
| browsermob.proxySize | int | `50` | Size of the proxy, when proxyBasePort is 8281 and size set to 50, proxy will use ports range 8281-8330 |
| browsermob.readinessProbe.enabled | bool | `true` | enables Browsermob pods readiness probe |
| browsermob.readinessProbe.failureThreshold | int | `6` |  |
| browsermob.readinessProbe.initialDelaySeconds | int | `30` |  |
| browsermob.readinessProbe.periodSeconds | int | `10` |  |
| browsermob.readinessProbe.successThreshold | int | `1` |  |
| browsermob.readinessProbe.timeoutSeconds | int | `5` |  |
| browsermob.resources.limits.cpu | string | `"500m"` | Browsermob limits cpu resources |
| browsermob.resources.limits.memory | string | `"300Mi"` | Browsermob limits memory resources |
| browsermob.resources.requests.cpu | string | `"100m"` | Browsermob request cpu resources |
| browsermob.resources.requests.memory | string | `"200Mi"` | Browsermob request memory resources |
| ingress.annotations | object | `{}` | ingress annotations |
| ingress.enabled | bool | `false` | enables ingress |
| ingress.host | string | `""` | ingress's spec rules host, supersedes `localDnsMapping` |
| ingress.localDnsMapping | string | `"aet-127.0.0.1.nip.io"` | if `host` is not set, this value will be used as ingress's spec rules host - use e.g. nip.io to have a working alias for your instance |
| karaf.configs.cleaner.dryRun | bool | `false` |  |
| karaf.configs.cleaner.keepNVersions | int | `150` |  |
| karaf.configs.cleaner.removeOlderThan | int | `4` |  |
| karaf.configs.cleaner.schedule | string | `"0 0 22 ? * *"` |  |
| karaf.configs.database.allowAutoCreate | bool | `true` | allows creating new databases by AET (no need to create them manually first, including indexes) |
| karaf.configs.runner.ft | int | `120` | Time in seconds, after which suite processing will be interrupted if no notification was received in duration of this parameter. That means if Runner will be not updated by any collection or comparison result in that time it will decide to force stop suite processing. |
| karaf.configs.runner.maxConcurrentSuitesCount | int | `2` | Defines the maximum number of suites processed concurrently byt the Runner. If more suites will come to the system, they will be scheduled for later processing. |
| karaf.configs.runner.maxMessagesInCollectorQueue | int | `4` | Defines the maximum amount of messages in the collector queue. This should be equal the total number of browser sessions provided by Selenium Grid and collector instances. |
| karaf.configs.runner.mttl | int | `300` | Time in seconds after which messages will be thrown out of queues. |
| karaf.configs.runner.urlPackageSize | int | `1` | Defines how many urls are being sent in one message. Do not change this value unless you are absolutly certain you know what you do :). |
| karaf.configs.workers.collectorInstancesNo | int | `4` |  |
| karaf.configs.workers.collectorPrefetchSize | int | `1` |  |
| karaf.configs.workers.comparatorInstancesNo | int | `5` |  |
| karaf.configs.workers.comparatorPrefetchSize | int | `1` |  |
| karaf.env.javaMaxMem | string | `"2048m"` |  |
| karaf.image.repository | string | `"skejven/aet_karaf"` | image repository for Apache Karaf |
| karaf.image.tag | string | `nil` | Karaf image tag, overrides `aetDockerTag` |
| karaf.initContainers.initTimeoutSeconds | int | `120` | time after which init checks for hub, mongo and activemq will timeout if not found in network |
| karaf.initContainers.waitForActivemq | bool | `true` | enables waiting for ActiveMq to be available before running the main Karaf conainer |
| karaf.initContainers.waitForHub | bool | `true` | enables waiting for Selenium Grid Hub to be available before running the main Karaf conainer |
| karaf.initContainers.waitForMongo | bool | `true` | enables waiting for MongoDB to be available before running the main Karaf conainer |
| karaf.livenessProbe.enabled | bool | `true` | enables Karaf pods liveness probe |
| karaf.livenessProbe.failureThreshold | int | `6` |  |
| karaf.livenessProbe.initialDelaySeconds | int | `120` |  |
| karaf.livenessProbe.periodSeconds | int | `30` |  |
| karaf.livenessProbe.successThreshold | int | `1` |  |
| karaf.livenessProbe.timeoutSeconds | int | `5` |  |
| karaf.ports.osgi | int | `8181` | Port with Karaf console and endpoints |
| karaf.readinessProbe.enabled | bool | `true` | enables Karaf pods readiness probe |
| karaf.readinessProbe.failureThreshold | int | `6` |  |
| karaf.readinessProbe.initialDelaySeconds | int | `120` |  |
| karaf.readinessProbe.periodSeconds | int | `10` |  |
| karaf.readinessProbe.successThreshold | int | `1` |  |
| karaf.readinessProbe.timeoutSeconds | int | `5` |  |
| karaf.resources.limits.cpu | string | `"1000m"` | Karaf limits cpu resources |
| karaf.resources.limits.memory | string | `"2000Mi"` | Karaf limits memory resources |
| karaf.resources.requests.cpu | string | `"750m"` | Karaf request cpu resources |
| karaf.resources.requests.memory | string | `"1500Mi"` | Karaf request memory resources |
| mongodb.arbiter.enabled | bool | `false` |  |
| mongodb.architecture | string | `"standalone"` |  |
| mongodb.auth.enabled | bool | `false` |  |
| mongodb.image.tag | string | `"3.6"` |  |
| mongodb.labels."app.kubernetes.io/component" | string | `"database"` |  |
| mongodb.labels."app.kubernetes.io/instance" | string | `"mongo-aet"` |  |
| mongodb.labels."app.kubernetes.io/managed-by" | string | `"kubectl"` |  |
| mongodb.labels."app.kubernetes.io/name" | string | `"mongo"` |  |
| mongodb.labels."app.kubernetes.io/part-of" | string | `"aet"` |  |
| mongodb.labels."app.kubernetes.io/version" | string | `"3.6"` |  |
| mongodb.nameOverride | string | `"aet-mongodb"` |  |
| mongodb.persistence.size | string | `"2Gi"` |  |
| mongodb.resources.limits.cpu | string | `"1000m"` |  |
| mongodb.resources.limits.memory | string | `"2Gi"` |  |
| mongodb.resources.requests.cpu | string | `"500m"` |  |
| mongodb.resources.requests.memory | string | `"512Mi"` |  |
| mongodb.service.port | int | `27017` |  |
| mongodb.strategyType | string | `"RollingUpdate"` |  |
| mongodb.useStatefulSet | bool | `true` |  |
| report.image.repository | string | `"skejven/aet_report"` | image repository for Reports |
| report.image.tag | string | `nil` | Reports image tag, overrides `aetDockerTag` |
| report.livenessProbe.enabled | bool | `true` | enables Reports pods liveness probe |
| report.livenessProbe.failureThreshold | int | `2` |  |
| report.livenessProbe.initialDelaySeconds | int | `15` |  |
| report.livenessProbe.periodSeconds | int | `30` |  |
| report.livenessProbe.successThreshold | int | `1` |  |
| report.livenessProbe.timeoutSeconds | int | `1` |  |
| report.ports.service | int | `80` | Port Reports will be served at |
| report.readinessProbe.enabled | bool | `true` | enables Reports pods readiness probe |
| report.readinessProbe.failureThreshold | int | `2` |  |
| report.readinessProbe.initialDelaySeconds | int | `15` |  |
| report.readinessProbe.periodSeconds | int | `10` |  |
| report.readinessProbe.successThreshold | int | `1` |  |
| report.readinessProbe.timeoutSeconds | int | `1` |  |
| report.resources.limits.cpu | string | `"100m"` | Reports limits cpu resources |
| report.resources.limits.memory | string | `"100Mi"` | Reports limits memory resources |
| report.resources.requests.cpu | string | `"50m"` | Reports request cpu resources |
| report.resources.requests.memory | string | `"50Mi"` | Reports request memory resources |
| sgrid.chrome.configs.maxInstancesPerNode | int | `1` | number of instances of same version of browser that can run in node |
| sgrid.chrome.configs.maxSessionsPerNode | int | `1` | number of browsers (Any browser and version) that can run in parallel at a time in node, overrides max instances settings by restricting the number of browser instances that can run in parallel |
| sgrid.chrome.image.repository | string | `"selenium/node-chrome"` |  |
| sgrid.chrome.image.tag | string | `"3.14.0-arsenic"` |  |
| sgrid.chrome.livenessProbe.enabled | bool | `true` | enables Selenium Grid Node pods liveness probe |
| sgrid.chrome.livenessProbe.failureThreshold | int | `2` |  |
| sgrid.chrome.livenessProbe.initialDelaySeconds | int | `30` |  |
| sgrid.chrome.livenessProbe.periodSeconds | int | `30` |  |
| sgrid.chrome.livenessProbe.successThreshold | int | `1` |  |
| sgrid.chrome.livenessProbe.timeoutSeconds | int | `5` |  |
| sgrid.chrome.readinessProbe.enabled | bool | `true` | enables Selenium Grid Node pods readiness probe |
| sgrid.chrome.readinessProbe.failureThreshold | int | `2` |  |
| sgrid.chrome.readinessProbe.initialDelaySeconds | int | `30` |  |
| sgrid.chrome.readinessProbe.periodSeconds | int | `30` |  |
| sgrid.chrome.readinessProbe.successThreshold | int | `1` |  |
| sgrid.chrome.readinessProbe.timeoutSeconds | int | `5` |  |
| sgrid.chrome.resources.limits.cpu | string | `"750m"` | Selenium Grid Node limits cpu resources |
| sgrid.chrome.resources.limits.memory | string | `"1250Mi"` | Selenium Grid Node limits memory resources |
| sgrid.chrome.resources.requests.cpu | string | `"250m"` | Selenium Grid Node request cpu resources |
| sgrid.chrome.resources.requests.memory | string | `"500Mi"` | Selenium Grid Node request memory resources |
| sgrid.hub.image.repository | string | `"selenium/hub"` |  |
| sgrid.hub.image.tag | string | `"3.14.0-arsenic"` |  |
| sgrid.hub.livenessProbe.enabled | bool | `true` | enables Selenium Grid Hub pods liveness probe |
| sgrid.hub.livenessProbe.failureThreshold | int | `6` |  |
| sgrid.hub.livenessProbe.initialDelaySeconds | int | `30` |  |
| sgrid.hub.livenessProbe.periodSeconds | int | `30` |  |
| sgrid.hub.livenessProbe.successThreshold | int | `1` |  |
| sgrid.hub.livenessProbe.timeoutSeconds | int | `5` |  |
| sgrid.hub.ports.service | int | `4444` | Port Selenium Grid Hub will be served at |
| sgrid.hub.readinessProbe.enabled | bool | `true` | enables Selenium Grid Hub pods readiness probe |
| sgrid.hub.readinessProbe.failureThreshold | int | `6` |  |
| sgrid.hub.readinessProbe.initialDelaySeconds | int | `15` |  |
| sgrid.hub.readinessProbe.periodSeconds | int | `10` |  |
| sgrid.hub.readinessProbe.successThreshold | int | `1` |  |
| sgrid.hub.readinessProbe.timeoutSeconds | int | `5` |  |
| sgrid.hub.resources.limits.cpu | string | `"800m"` | Selenium Grid Hub limits cpu resources |
| sgrid.hub.resources.limits.memory | string | `"1250Mi"` | Selenium Grid Hub limits memory resources |
| sgrid.hub.resources.requests.cpu | string | `"200m"` | Selenium Grid Hub request cpu resources |
| sgrid.hub.resources.requests.memory | string | `"750Mi"` | Selenium Grid Hub request memory resources |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | 10.20.0 |

This chart depends on [Bitnami MongoDB chart](https://github.com/bitnami/charts/tree/master/bitnami/mongodb).
By default settings of this chart, MongoDB runs in `standalone` mode as Statefull Set and RollingUpdate.

## Development

1. Checkout repo and change directory to `charts/aet`
2. Build dependencies: `helm dependency build`
3. Instal AET (locally): `helm install --set ingress.enabled=true local . -n aet --create-namespace`

Your AET instance domain should be `http://aet-127.0.0.1.nip.io/`

## Improvements (help wanted)
- [ ] upgrade ingress apiVersion
- [ ] scale AET capacity with one property (currently you need to update number of browsers, collectors and queue settings)
- [ ] prepare guide on how to install it on AWS/Azure/GCP