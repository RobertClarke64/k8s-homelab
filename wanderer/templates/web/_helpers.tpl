{{/*
Expand the name of the chart.
*/}}
{{- define "wanderer.web.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 59 | trimSuffix "-" }}-web
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wanderer.web.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 59 | trimSuffix "-" }}-web
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 59 | trimSuffix "-" }}-web
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 59 | trimSuffix "-" }}-web
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wanderer.web.labels" -}}
helm.sh/chart: {{ include "wanderer.chart" . }}
{{ include "wanderer.web.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wanderer.web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wanderer.web.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
