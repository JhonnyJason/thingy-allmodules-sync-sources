##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("startupmodule")

#endregion

##############################################################################
#region modulesFromEnvironment
import * as c from 'chalk'

##############################################################################
import *  as syncProcess from "./syncprocessmodule"
import * as cliArguments from "./cliargumentsmodule"

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
        # console.log(chalk.yellow("caught arguments are: " + args._))
        done = await syncProcess.execute(e.thingyPath)
        if done then successLog 'All done!'
    catch err
        errLog 'Error!'
        console.log err
        console.log "\n"

