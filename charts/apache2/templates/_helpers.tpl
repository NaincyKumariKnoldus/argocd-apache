{{- define "{{ .Chart.Name }}.Strategy" }}
{{- if .Values.deployment.strategy }}
{{- with .Values.deployment.strategy }}
strategy:
{{- if eq .type "RollingUpdate" }}
  type: {{ .type }}
  rollingUpdate:
    maxSurge: {{ .rollingUpdate.maxSurge }}
    maxUnavailable: {{ .rollingUpdate.maxUnavailable }}
{{- else if eq .type "Recreate" }}
type: {{ .type }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}


{{- define "Label.Generator" }}
{{- range $key, $val := .Values.deployment.labels }}
 {{ $key }}: {{ $val }}
{{- end }}
{{- end }}

{{- define "Service.type" }}
{{- with .Values.service }}
{{- if or (eq .type "NodePort") (eq .type "LoadBalancer") -}}
{{- range $key, $value := .ports }}
{{- if eq $key "name" }}
- {{ $key }}: {{ $value }}
{{- else }}
  {{ $key }}: {{ $value }}
  {{- end }}
{{- end }}
{{- else if eq .type "ClusterIP" }}
{{- range $key, $value := .ports }}
{{- if ne $key "nodePort" }}
{{- if eq $key "name" }}
- {{ $key }}: {{ $value }}
{{- else }}
  {{ $key }}: {{ $value }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
