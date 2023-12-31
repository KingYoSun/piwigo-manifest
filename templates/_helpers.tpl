{{/*
Expand the name of the chart.
*/}}
{{- define "piwigo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "piwigo.fullname" -}}
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
{{- define "piwigo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "piwigo.labels" -}}
helm.sh/chart: {{ include "piwigo.chart" . }}
{{ include "piwigo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels(mysql)
*/}}
{{- define "piwigo-mysql.labels" -}}
helm.sh/chart: {{ include "piwigo.chart" . }}
{{ include "piwigo-mysql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels(redis)
*/}}
{{- define "piwigo-redis.labels" -}}
helm.sh/chart: {{ include "piwigo.chart" . }}
{{ include "piwigo-redis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "piwigo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "piwigo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels(mysql)
*/}}
{{- define "piwigo-mysql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "piwigo.name" . }}-mysql
app.kubernetes.io/instance: {{ .Release.Name }}-mysql
{{- end }}

{{/*
Selector labels(redis)
*/}}
{{- define "piwigo-redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "piwigo.name" . }}-redis
app.kubernetes.io/instance: {{ .Release.Name }}-redis
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "piwigo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "piwigo.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
