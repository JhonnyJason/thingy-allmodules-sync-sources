##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("allmodulesgenmodule")

#endregion

################################################################################
#region imports
import fs from "fs-extra"
import M from  "mustache"
import * as pathModule from "path"

################################################################################
import * as pathHandler from "./pathhandlermodule.js"
import * as cfg from "./configmodule.js" 

#endregion

################################################################################
#region templates
allModulesTemplate = """
    {{#modules}}
    import * as {{.}} from "./{{.}}.js"
    {{/modules}}

    Modules = {
    {{#modules}}
        {{.}},
    {{/modules}}
    }

    export default Modules
    """

allStylesTemplate = """
    {{#modules}}
    @import '../{{.}}/styles.styl'
    {{/modules}}
    """

#endregion

################################################################################
#region internal functions
writeStyl = (styleModules) ->
    log "writeStyl"

    fileName = cfg.outputStylusName
    filePath = pathModule.resolve(pathHandler.getAllmodulesPath(), fileName)

    fileContent = M.render(allStylesTemplate, {modules: styleModules})
    
    log "filePath: " + filePath
    log "\n - - - \nfileContent:\n" + fileContent
    await fs.writeFile(filePath, fileContent)
    return

writeCoffee = (coffeeModules) ->
    log "writeCoffee"

    fileName = cfg.outputCoffeeName
    filePath = pathModule.resolve(pathHandler.getAllmodulesPath(), fileName)

    fileContent = M.render(allModulesTemplate, {modules: coffeeModules})
    
    log "filePath: " + filePath
    log "\n - - - \nfileContent:\n" + fileContent
    await fs.writeFile(filePath, fileContent)

    return

#endregion

################################################################################
#region exports
export generate = (modules) ->
    log "generate"

    promises = []
    if modules.coffee && modules.coffee.length > 0
        promises.push(writeCoffee(modules.coffee))
    
    if modules.style && modules.style.length > 0
        promises.push(writeStyl(modules.style))
    
    await Promise.all(promises)
    return
    
#endregion
