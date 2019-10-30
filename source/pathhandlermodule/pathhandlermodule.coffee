pathhandlermodule = {name: "pathhandlermodule"}

#region node_modules
c           = require('chalk');
CLI         = require('clui');
Spinner     = CLI.Spinner;
fs          = require("fs-extra")
pathModule  = require("path")
#endregion

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["pathhandlermodule"]?  then console.log "[pathhandlermodule]: " + arg
    return

#region internal variables
utl = null
#endregion

#region exposed variables
pathhandlermodule.sourcePath = ""
pathhandlermodule.allmodulesPath = ""
pathhandlermodule.thingyPath = ""
#endregion

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
pathhandlermodule.initialize = () ->
    log "pathhandlermodule.initialize"
    utl = allModules.utilmodule
    return

#region internal functions
findSourcePath = ->
    log "findSourcePath"
    sourcePath = pathModule.resolve(pathhandlermodule.thingyPath, "sources/source")
    exists = await utl.pathIsDir(sourcePath)
    if !exists
        throw new Error("sourcePath: " + sourcePath + " did not exist! The provided path might not be the thingy root.")
    pathhandlermodule.sourcePath = sourcePath

findAllmodulesPath = ->
    log "findAllmodulesPath"
    allmodulesPath = pathModule.resolve(pathhandlermodule.sourcePath, "allmodules")
    exists = await utl.pathIsDir(allmodulesPath)
    if !exists then await fs.mkdirs(allmodulesPath)
    pathhandlermodule.allmodulesPath = allmodulesPath

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
    
    pathhandlermodule.thingyPath = providedPath

#endregion

#region exposed functions
pathhandlermodule.checkPaths = (providedPath) ->
    log "pathhandlermodule.checkPaths"

    log "checking for providedPath: " + providedPath
    await checkProvidedPath(providedPath)
    log "resulting thingy path is: " + pathhandlermodule.thingyPath
        
    await findSourcePath()
    await findAllmodulesPath()

pathhandlermodule.getCoffeePath = (module) ->
    log "pathhandlermodule.getCoffeeModulePath"
    pathPostfix = "" + module + "/" + module + ".coffee"
    return pathModule.resolve(pathhandlermodule.sourcePath, pathPostfix)

pathhandlermodule.getStylePath = (module) ->
    log "pathhandlermodule.getStylePath"
    pathPostfix = "" + module + "/styles.styl"
    return pathModule.resolve(pathhandlermodule.sourcePath, pathPostfix)

pathhandlermodule.getPackageJsonPath = ->
    log "pathhandlermodule.getPackageJsonPath"
    return pathModule.resolve(pathhandlermodule.thingyPath, "package.json")

pathhandlermodule.getAllmodulesPath = -> pathhandlermodule.allmodulesPath

pathhandlermodule.getSourcePath = -> pathhandlermodule.sourcePath
#endregion

module.exports = pathhandlermodule
