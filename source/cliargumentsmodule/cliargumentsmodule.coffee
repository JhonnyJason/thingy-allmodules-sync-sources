################################################################################
#region logSwitch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["cliargumentsmodule"]?  then console.log "[cliargumentsmodule]: " + arg
    return
#endregion

################################################################################
import meow from 'meow'

################################################################################
#region internal functions
getHelpText = ->
    log "getHelpText"
    return """
    Usage
        $ thingy-allmodules-sync <arg1>

    Options
        optional:
            arg1, --thingy-path <path/to/thingy>, -p <path/to/thingy> [default: ./ ]
                path to the root of the thingy. Usually it is cwd. Use it if you call this script from somewhere else.

    TO NOTE:
        The flags will overwrite the flagless argument.
    Examples
        $ thingy-allmodules-sync 
        ...
    """
    
getOptions = ->
    log "getOptions"
    return {
        importMeta: import.meta,
        flags:
            thingyPath:
                type: "string"
                alias: "p"
    }

extractMeowed = (meowed) ->
    log "extractMeowed"
    thingyPath = ""
    style = ""

    if meowed.input[0]
        thingyPath = meowed.input[0]

    if meowed.flags.thingyPath
        thingyPath = meowed.flags.thingyPath

    # introducing the defaults here as they otherwise
    if !thingyPath then thingyPath = "."

    return {thingyPath}

throwErrorOnUsageFail = (extract) ->
    log "throwErrorOnUsageFail"
    if !extract.thingyPath
        throw "fatal error: no default thingyPath was not available as fallback!"
    
    if !(typeof extract.thingyPath == "string")
        throw "Usage error: option thingyPath was provided in an unexpected way!"
    return
    
#endregion

################################################################################
#region exposed functions
export extractArguments = ->
    log "extractArguments"
    meowed = meow(getHelpText(), getOptions())
    extract = extractMeowed(meowed)
    throwErrorOnUsageFail(extract)
    return extract

#endregion
