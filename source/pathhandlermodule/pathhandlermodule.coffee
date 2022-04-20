##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("pathhandlermodule")

#endregion

##############################################################################
#region modulesFromEnvironment
import fs from "fs-extra"
import c from 'chalk'
import * as pathModule from "path"

##############################################################################
import  * as utl from "./utilmodule.js"

#endregion

##############################################################################
sourcePath = ""
allmodulesPath = ""
thingyPath = ""

##############################################################################
#region internal functions
findSourcePath = ->
    log "findSourcePath"
    sourcePath = pathModule.resolve(thingyPath, "sources/source")
    exists = await utl.pathIsDir(sourcePath)
    if !exists
        throw new Error("sourcePath: " + sourcePath + " did not exist! The provided path might not be the thingy root.")
    sourcePath = sourcePath
    return

findAllmodulesPath = ->
    log "findAllmodulesPath"
    allmodulesPath = pathModule.resolve(sourcePath, "allmodules")
    exists = await utl.pathIsDir(allmodulesPath)
    if !exists then await fs.mkdirs(allmodulesPath)
    allmodulesPath = allmodulesPath
    return

checkProvidedPath = (providedPath) ->
    log "checkProvidedPath"

    if providedPath
        if !pathModule.isAbsolute(providedPath)
            providedPath = pathModule.resolve(process.cwd(), providedPath)
    else
        providedPath = process.cwd()

    exists = await utl.pathIsDir(providedPath)
    if !exists
        throw new Error("Provided path:'" + providedPath + "' does not exist!")
    
    thingyPath = providedPath
    return

#endregion

##############################################################################
#region exposed functions
export checkPaths = (providedPath) ->
    log "checkPaths"

    log "checking for providedPath: " + providedPath
    await checkProvidedPath(providedPath)
    log "resulting thingy path is: " + thingyPath
        
    await findSourcePath()
    await findAllmodulesPath()
    return

export getCoffeePath = (module) ->
    log "getCoffeeModulePath"
    pathPostfix = "" + module + "/" + module + ".coffee"
    return pathModule.resolve(sourcePath, pathPostfix)

export getStylePath = (module) ->
    log "getStylePath"
    pathPostfix = "" + module + "/styles.styl"
    return pathModule.resolve(sourcePath, pathPostfix)

export getPackageJsonPath = ->
    log "getPackageJsonPath"
    return pathModule.resolve(thingyPath, "package.json")

##############################################################################
export getSourcePath = -> sourcePath

export getAllmodulesPath = -> allmodulesPath

export getThingyPath = -> thingyPath

#endregion
