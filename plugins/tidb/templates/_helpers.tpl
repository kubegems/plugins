{{- define "tidb.secret.name" -}}
{{ include "common.names.fullname" .}}-tidb-secret
{{- end -}}

{{- define "tidb.cluster.name" -}}
{{ include "common.names.fullname" .}}-tidb
{{- end -}}

{{- define "tidb.root.password" -}}
    {{- if .Values.cluster.rootPassword }}
        {{- .Values.cluster.rootPassword }}
    {{- else }}
        {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "tidb.secret.name" .) "Length" 10 "Key" "root") }}
    {{- end }}
{{- end -}}


{{- define "getValueFromSecret" }}
    {{- $len := (default 16 .Length) | int -}}
    {{- $obj := (lookup "v1" "Secret" .Namespace .Name).data -}}
    {{- if $obj }}
        {{- index $obj .Key | b64dec -}}
    {{- else -}}
        {{- randAlphaNum $len -}}
    {{- end -}}
{{- end }}