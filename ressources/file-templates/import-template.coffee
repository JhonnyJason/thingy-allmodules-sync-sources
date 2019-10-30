{{#modules}}
import {{.}} from "./{{.}}"
{{/modules}}

Modules = {
{{#modules}}
    {{.}},
{{/modules}}
}

export default Modules