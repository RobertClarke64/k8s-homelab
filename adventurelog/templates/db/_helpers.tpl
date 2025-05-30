{{/*
Expand the name of the chart.
*/}}
{{- define "adventurelog.db.name" -}}
{{- include "adventurelog.name" . | trunc 60 | trimSuffix "-" }}-db
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "adventurelog.db.fullname" -}}
{{- include "adventurelog.fullname" . | trunc 60 | trimSuffix "-" }}-db
{{- end }}

{{/*
Common labels
*/}}
{{- define "adventurelog.db.labels" -}}
{{ include "adventurelog.labels" . }}
{{ include "adventurelog.db.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "adventurelog.db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "adventurelog.db.name" . }}
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
