utilmodule = {name: "utilmodule"}

#region noode_modules
fs = require "fs-extra"
#endregion

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["utilmodule"]?  then console.log "[utilmodule]: " + arg
    return

#region internal variables
#endregion

#region exposed variables
#endregion


##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
utilmodule.initialize = () ->
    log "utilmodule.initialize"

#region internal functions
#endregion

#region exposed functions
utilmodule.pathIsDir = (path) ->
    try
        stats = await fs.lstat(path)
        return stats.isDirectory()
    catch err
        # console.log(c.red(err.message))
        return false

utilmodule.pathExists = (path) ->
    try
        await fs.lstat(path)
        return true
    catch err
        # console.log(c.red(err.message))
        return false
#endregion

module.exports = utilmodule
