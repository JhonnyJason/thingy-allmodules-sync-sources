cliargumentsmodule = {name: "cliargumentsmodule"}

#region node_modules
meow       = require('meow')
#endregion

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["cliargumentsmodule"]?  then console.log "[cliargumentsmodule]: " + arg
    return

#region internal variables

#endregion

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
cliargumentsmodule.initialize = () ->
    log "cliargumentsmodule.initialize"
    return

#region internal functions
getHelpText = ->
    log "getHelpText"
    return """
    Usage
        $ thingy-allmodules-sync <arg1> <arg2>

    Options
        optional:
            arg1, --thingy-path <path/to/thingy>, -p <path/to/thingy> [default: ./ ]
                path to the root of the thingy. Usually it is cwd. Use it if you call this script from somewhere else.
            arg2, --style <importStyle>, -s <importStyle> [default: import]
                determines if we use require or import can either be "require" or "import"
    TO NOTE:
        The flags will overwrite the flagless argument.
    Examples
        $ thingy-allmodules-sync 
        ...
    """
    
getOptions = ->
    log "getOptions"
    return {
        flags:
            thingyPath:
                type: "string"
                alias: "p"
            style:
                type: "string"
                alias: "s"
    }

extractMeowed = (meowed) ->
    log "extractMeowed"
    thingyPath = ""
    style = ""

    if meowed.input[0]
        thingyPath = meowed.input[0]
    if meowed.input[1]
        style = meowed.input[1]

    if meowed.flags.thingyPath
        thingyPath = meowed.flags.thingyPath
    if meowed.flags.style
        style = meowed.flags.style

    # introducing the defaults here as they otherwise
    if !thingyPath then thingyPath = "."
    if !style then style = "import"

    return {thingyPath,style}

throwErrorOnUsageFail = (extract) ->
    log "throwErrorOnUsageFail"
    if !extract.thingyPath
        throw "fatal error: no default thingyPath was not available as fallback!"
    if !extract.style
        throw "fatal error: no default style was not available as fallback!"
    
    if !(typeof extract.thingyPath == "string")
        throw "Usage error: option thingyPath was provided in an unexpected way!"
    if !(typeof extract.style == "string")
        throw "Usage error: option style was provided in an unexpected way!"
    if(extract.style != "import" and extract.style != "require")
        throw "Usage error: option style must be either import or require!"

#endregion

#region exposed functions
cliargumentsmodule.extractArguments = ->
    log "cliargumentsmodule.extractArguments"
    options = getOptions()
    meowed = meow(getHelpText(), getOptions())
    extract = extractMeowed(meowed)
    throwErrorOnUsageFail(extract)
    return extract

#endregion exposed functions

module.exports = cliargumentsmodule
