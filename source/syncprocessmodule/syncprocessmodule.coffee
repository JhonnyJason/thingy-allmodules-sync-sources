##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("syncprocessmodule")

#endregion

##############################################################################
#region modulesFromEnvironment
import c from 'chalk'

##############################################################################
import * as pathHandler from "./pathhandlermodule.js"
import * as moduleSearch from "./modulesearchmodule.js"
import * as allmodulesgen from "./allmodulesgenmodule.js"

#endregion

##############################################################################
successMessage = (arg) -> console.log(c.green(arg))

##############################################################################
export execute = (path) ->
    log "execute"
    olog {path}
    await pathHandler.checkPaths(path)
    modules = await moduleSearch.searchModules()
    log "found modules\n" + JSON.stringify(modules, null, 4)
    await allmodulesgen.generate(modules)
    return true
    
