Modules =
{{#modules}}
    {{.}}: require "./{{.}}"
{{/modules}}

module.exports = Modules