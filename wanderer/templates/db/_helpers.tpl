{{/*
Expand the name of the chart.
*/}}
{{- define "wanderer.db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 60 | trimSuffix "-" }}-db
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wanderer.db.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 60 | trimSuffix "-" }}-db
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 60 | trimSuffix "-" }}-db
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 60 | trimSuffix "-" }}-db
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wanderer.db.labels" -}}
helm.sh/chart: {{ include "wanderer.chart" . }}
{{ include "wanderer.db.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wanderer.db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wanderer.db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
