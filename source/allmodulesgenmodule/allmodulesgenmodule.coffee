##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("allmodulesgenmodule")

#endregion

################################################################################
#region modulesFromTheEnvironment

################################################################################
#region node_modules
import fs from "fs-extra"
import * as mustache from  "mustache"
import * as pathModule from "path"

#endregion

################################################################################
#region localModules
pathHandler = null
cfg = null

#endregion

#endregion

################################################################################
export initialize = ->
    log "initialize"
    pathHandler = allModules.pathhandlermodule
    cfg = allModules.configmodule
    return

################################################################################
#region internalFunctions
writeStyl = (styleModules) ->
    log "writeStyl"

    templatePath = pathModule.resolve(__dirname, "file-templates/allstyles.mustache")
    fileName = cfg.outputStylusName
    filePath = pathModule.resolve(pathHandler.allmodulesPath,  fileName)
    # log "filePath: " + filePath

    template = await fs.readFile(templatePath, "utf-8")        
    fileContent = mustache.render(template, {modules: styleModules})
    
    # log "\n - - - \nfileContent:\n" + fileContent
    await fs.writeFile(filePath, fileContent)
    return

writeCoffee = (coffeeModules) ->
    log "writeCoffee"

    templatePath = pathModule.resolve(__dirname, "file-templates/allmodules.mustache")
    fileName = cfg.outputCoffeeName
    filePath = pathModule.resolve(pathHandler.allmodulesPath,  fileName)
    # log "filePath: " + filePath

    template = await fs.readFile(templatePath, "utf-8")        
    fileContent = mustache.render(template, {modules: coffeeModules})
    
    # log "\n - - - \nfileContent:\n" + fileContent
    await fs.writeFile(filePath, fileContent)

    return

#endregion

################################################################################
#region exposedFunctions
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
