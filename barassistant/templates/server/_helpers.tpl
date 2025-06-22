{{/*
Expand the name of the chart.
*/}}
{{- define "barassistant.server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 56 | trimSuffix "-" }}-server
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "barassistant.server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 56 | trimSuffix "-" }}-server
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 56 | trimSuffix "-" }}-server
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 56 | trimSuffix "-" }}-server
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "barassistant.server.labels" -}}
helm.sh/chart: {{ include "barassistant.chart" . }}
{{ include "barassistant.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "barassistant.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "barassistant.server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

