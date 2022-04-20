##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("startupmodule")

#endregion

##############################################################################
#region modulesFromEnvironment
import c from 'chalk'

##############################################################################
import *  as syncProcess from "./syncprocessmodule.js"
import * as cliArguments from "./cliargumentsmodule.js"

#endregion

##############################################################################
#region internal variables
errLog = (arg) -> console.log(c.red(arg))
successLog = (arg) -> console.log(c.green(arg))

#endregion

##############################################################################
export cliStartup = ->
    log "cliStartup"
    try
        e = cliArguments.extractArguments()
        done = await syncProcess.execute(e.thingyPath)
        if done then successLog 'All done!'
    catch err
        errLog 'Error!'
        console.log err
        console.log "\n"

