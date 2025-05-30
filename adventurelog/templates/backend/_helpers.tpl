{{/*
Expand the name of the chart.
*/}}
{{- define "adventurelog.backend.name" -}}
{{- include "adventurelog.name" . | trunc 55 | trimSuffix "-" }}-backend
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "adventurelog.backend.fullname" -}}
{{- include "adventurelog.fullname" . | trunc 55 | trimSuffix "-" }}-backend
{{- end }}

{{/*
Common labels
*/}}
{{- define "adventurelog.backend.labels" -}}
{{ include "adventurelog.labels" . }}
{{ include "adventurelog.backend.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "adventurelog.backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "adventurelog.backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "adventurelog.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "adventurelog.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
