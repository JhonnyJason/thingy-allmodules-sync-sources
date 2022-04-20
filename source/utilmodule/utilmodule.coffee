##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("utilmodule")

#endregion

##############################################################################
import fs from "fs-extra"

##############################################################################
#region exposed functions
export pathIsDir = (path) ->
    try
        stats = await fs.lstat(path)
        return stats.isDirectory()
    catch err
        # console.log(c.red(err.message))
        return false

export pathExists = (path) ->
    try
        await fs.lstat(path)
        return true
    catch err
        # console.log(c.red(err.message))
        return false
#endregion
