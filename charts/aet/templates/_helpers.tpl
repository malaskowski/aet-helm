{{/*
Expand the name of the chart.
*/}}
{{- define "aet-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "aet-helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aet-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Proxy service ports list
*/}}
{{- define "aet-helm.proxyServicePortsList" -}}
{{- $basePort := default 8082 .Values.browsermob.proxyBasePort -}}
{{- range $i, $e := until (.Values.browsermob.proxySize|int) -}}
{{- $currentPort := (add $e $basePort) }}
- name: '{{$currentPort}}'
  port: {{$currentPort}}
  targetPort: {{$currentPort}}
{{- end -}}
{{- end -}}


{{/*
Proxy port range
*/}}
{{- define "aet-helm.proxyPortRange" -}}
{{- $basePort := default 8082 .Values.browsermob.proxyBasePort|int -}}
{{- $proxySize := default 50 .Values.browsermob.proxySize|int -}}
{{ printf "%d-%d" $basePort (sub (add $basePort $proxySize) 1) }}
{{- end -}}

# {{- .Values.karaf.configs.runner.maxConcurrentSuitesCount -}} = ceil(aetCollectionThroughput / 3)
# {{- .Values.karaf.configs.runner.maxMessagesInCollectorQueue -}} = aetCollectionThroughput
# {{- .Values.karaf.configs.workers.collectorInstancesNo -}} = aetCollectionThroughput
# {{- .Values.sgrid.chrome.replicas -}} = ceil(aetCollectionThroughput / maxSessionsPerNode)

{{/*
Returns karaf's runner maxConcurrentSuitesCount depending on aetCollectionThroughput value
*/}}
{{- define "aet-helm.runnerMaxConcurrentSuitesCount" -}}
{{- if .Values.aetCollectionThroughput }}
{{- ceil (div .Values.aetCollectionThroughput 3) }}
{{- else }}
{{- .Values.karaf.configs.runner.maxConcurrentSuitesCount }}
{{- end }}
{{- end }}

{{/*
Returns karaf's runner maxMessagesInCollectorQueue depending on aetCollectionThroughput value
*/}}
{{- define "aet-helm.runnerMaxMessagesInCollectorQueue" -}}
{{- if .Values.aetCollectionThroughput }}
{{- .Values.aetCollectionThroughput }}
{{- else }}
{{- .Values.karaf.configs.runner.maxMessagesInCollectorQueue }}
{{- end }}
{{- end }}

{{/*
Returns karaf's worker collectorInstancesNo depending on aetCollectionThroughput value
*/}}
{{- define "aet-helm.workerCollectorInstancesNo" -}}
{{- if .Values.aetCollectionThroughput }}
{{- .Values.aetCollectionThroughput }}
{{- else }}
{{- .Values.karaf.configs.workers.collectorInstancesNo }}
{{- end }}
{{- end }}

{{/*
Returns Selenium Grid's chrome replicas depending on aetCollectionThroughput value
*/}}
{{- define "aet-helm.sgridChromeReplicas" -}}
{{- if and (.Values.aetCollectionThroughput) (.Values.sgrid.chrome.configs.maxSessionsPerNode) }}
{{- ceil (div .Values.aetCollectionThroughput .Values.sgrid.chrome.configs.maxSessionsPerNode) }}
{{- else }}
{{- .Values.sgrid.chrome.replicas }}
{{- end }}
{{- end }}
