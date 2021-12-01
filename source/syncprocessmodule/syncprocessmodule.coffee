syncprocessmodule = {name: "syncprocessmodule"}

#region node_modules
c       = require('chalk')
#endregion

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["syncprocessmodule"]?  then console.log "[syncprocessmodule]: " + arg
    return

#region internal variables
successMessage = (arg) -> console.log(c.green(arg))

pathHandler = null
moduleSearch = null
allmodulesgen = null
#endregion

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
syncprocessmodule.initialize = () ->
    log "syncprocessmodule.initialize"
    pathHandler = allModules.pathhandlermodule
    moduleSearch = allModules.modulesearchmodule
    allmodulesgen = allModules.allmodulesgenmodule

#region internal functions
#endregion

#region exposed functions
syncprocessmodule.execute = (path) ->
    log "syncprocessmodule.execute"
    await pathHandler.checkPaths(path)
    modules = await moduleSearch.searchModules()
    log "found modules\n" + JSON.stringify(modules, null, 4)
    await allmodulesgen.generate(modules)
    return true
    
#endregion

module.exports = syncprocessmodule
