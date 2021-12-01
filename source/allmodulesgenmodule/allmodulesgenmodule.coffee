allmodulesgenmodule = {name: "allmodulesgenmodule"}

#region modulesFromTheEnvironment
#region node_modules
fs = require "fs-extra"
mustache = require "mustache"
pathModule = require "path"
#endregion

#region localModules
pathHandler = null
cfg = null
#endregion
#endregion

#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["allmodulesgenmodule"]?  then console.log "[allmodulesgenmodule]: " + arg
    return
#endregion
################################################################################
allmodulesgenmodule.initialize = () ->
    log "allmodulesgenmodule.initialize"
    pathHandler = allModules.pathhandlermodule
    cfg = allModules.configmodule
    return

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

#region exposedFunctions
allmodulesgenmodule.generate = (modules) ->
    log "allmodulesgenmodule.generate"

    promises = []
    if modules.coffee && modules.coffee.length > 0
        promises.push(writeCoffee(modules.coffee))
    
    if modules.style && modules.style.length > 0
        promises.push(writeStyl(modules.style))
    
    await Promise.all(promises)
    return
    
#endregion

module.exports = allmodulesgenmodule