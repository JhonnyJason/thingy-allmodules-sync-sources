toJson = (obj) -> JSON.stringify(obj, null, 4)

export getLogFunctions = (modulename) ->
    log = (arg) ->
        if modulesToDebug[modulename]  then console.log "["+modulename+"]: " + arg
        return
    olog = (obj) -> log "\n" + ostr(obj)
    return { log, olog }

export switchOnDebugging = (modulename) ->
    modulesToDebug[modulename] = true
    return

export switchOffDebugging = (modulename) ->
    delete modulesToDebug[modulename]
    return

export addModulesToDebug = (toDebug) ->
    for name,toD of toDebug when toD then modulesToDebug[name] = true
    return

################################################################################
import { addModulesToDebug } from "thingy-debug"

################################################################################
modulesToDebug = 
    unbreaker: true
    # allmodulesgenmodule: true
    # cliargumentsmodule: true
    # configmodule: true
    # syncprocessmodule: true
    # modulesearchmodule: true
    # pathhandlermodule: true
    # startupmodule: true
    # utilmodule: true

addModulesToDebug(modulesToDebug)