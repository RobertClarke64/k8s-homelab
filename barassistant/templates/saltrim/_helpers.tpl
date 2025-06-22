{{/*
Expand the name of the chart.
*/}}
{{- define "barassistant.saltrim.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 54 | trimSuffix "-" }}-saltrim
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "barassistant.saltrim.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 55 | trimSuffix "-" }}-saltrim
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 55 | trimSuffix "-" }}-saltrim
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 55 | trimSuffix "-" }}-saltrim
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "barassistant.saltrim.labels" -}}
helm.sh/chart: {{ include "barassistant.chart" . }}
{{ include "barassistant.saltrim.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "barassistant.saltrim.selectorLabels" -}}
app.kubernetes.io/name: {{ include "barassistant.saltrim.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

