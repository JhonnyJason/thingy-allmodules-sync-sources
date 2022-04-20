##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("modulesearchmodule")

#endregion

##############################################################################
#region modulesFromEnvironment
import fs from "fs-extra"

##############################################################################
import * as pathHandler from "./pathhandlermodule.js"
import * as utl from "./utilmodule.js"

#endregion

##############################################################################
export initialize = ->
    log "initialize"
    pathHandler = allModules.pathhandlermodule
    utl = allModules.utilmodule
    return
    
##############################################################################
#region internal functions
isModule = (dirname) ->
    if !dirname then return false
    if dirname.endsWith("module") then return true
    return false

isCoffeeModule = (dir) ->
    # log "isCoffeeModule"
    path = pathHandler.getCoffeePath(dir)
    exists = await utl.pathExists(path)
    # log "path: " + path
    # log "does exist? " + exists
    if exists then return dir
    else return false

isStyleModule = (dir) ->
    # log "isStyleModule"
    path = pathHandler.getStylePath(dir)
    exists = await utl.pathExists(path)
    # log "path: " + path
    # log "does exist? " + exists
    if exists then return dir
    else return false

#endregion

##############################################################################
#region exposed functions
export searchModules = ->
    log "searchModules"

    dirs = await fs.readdir(pathHandler.sourcePath)
    # log "read dirs:\n" + JSON.stringify(dirs, null, 4)

    coffeeCheckPromises = (isCoffeeModule(dir) for dir in dirs when isModule(dir))
    styleCheckPromises = (isStyleModule(dir) for dir in dirs when isModule(dir))

    coffeeResults = await Promise.all(coffeeCheckPromises)
    styleResults = await Promise.all(styleCheckPromises)

    modules = {}
    modules.coffee = (result for result in coffeeResults when result)
    modules.style = (result for result in styleResults when result)

    return modules

#endregion
