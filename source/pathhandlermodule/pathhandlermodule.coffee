##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("pathhandlermodule")

#endregion

##############################################################################
#region modulesFromEnvironment
import fs from "fs-extra"
import * as c from 'chalk'
import * as pathModule from "path"

##############################################################################
import  * as utl from "./utilmodule.js"

#endregion

##############################################################################
#region exposed variables
o = {
    sourcePath: ""
    allmodulesPath: ""
    thingyPath: ""
} 
export sourcePath = o.sourcePath
export allmodulesPath = o.allmodulesPath
export thingyPath = o.thingyPath
#endregion

##############################################################################
#region internal functions
findSourcePath = ->
    log "findSourcePath"
    sourcePath = pathModule.resolve(o.thingyPath, "sources/source")
    exists = await utl.pathIsDir(sourcePath)
    if !exists
        throw new Error("sourcePath: " + sourcePath + " did not exist! The provided path might not be the thingy root.")
    o.sourcePath = sourcePath

findAllmodulesPath = ->
    log "findAllmodulesPath"
    allmodulesPath = pathModule.resolve(o.sourcePath, "allmodules")
    exists = await utl.pathIsDir(allmodulesPath)
    if !exists then await fs.mkdirs(allmodulesPath)
    o.allmodulesPath = allmodulesPath

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
    
    o.thingyPath = providedPath

#endregion

##############################################################################
#region exposed functions
export checkPaths = (providedPath) ->
    log "checkPaths"

    log "checking for providedPath: " + providedPath
    await checkProvidedPath(providedPath)
    log "resulting thingy path is: " + o.thingyPath
        
    await findSourcePath()
    await findAllmodulesPath()

export getCoffeePath = (module) ->
    log "getCoffeeModulePath"
    pathPostfix = "" + module + "/" + module + ".coffee"
    return pathModule.resolve(o.sourcePath, pathPostfix)

export getStylePath = (module) ->
    log "getStylePath"
    pathPostfix = "" + module + "/styles.styl"
    return pathModule.resolve(o.sourcePath, pathPostfix)

export getPackageJsonPath = ->
    log "getPackageJsonPath"
    return pathModule.resolve(o.thingyPath, "package.json")

export getAllmodulesPath = -> o.allmodulesPath

export getSourcePath = -> o.sourcePath
#endregion
