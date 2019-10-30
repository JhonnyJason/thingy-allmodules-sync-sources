allmodulesgenmodule = {name: "allmodulesgenmodule"}

#region node_modules
fs = require "fs-extra"
mustache = require "mustache"
pathModule = require "path"
#endregion

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["allmodulesgenmodule"]?  then console.log "[allmodulesgenmodule]: " + arg
    return

#region internal variables
pathHandler = null
#endregion

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
allmodulesgenmodule.initialize = () ->
    log "allmodulesgenmodule.initialize"
    pathHandler = allModules.pathhandlermodule
    return


#region internal functions
writeRequireCoffee = (coffeeModules) ->
    log "writeCoffeeRequireStyle"

    templatePath = pathModule.resolve(__dirname, "file-templates/require-template.coffee")
    fileName = "modules.coffee"
    filePath = pathModule.resolve(pathHandler.allmodulesPath,  fileName)
    # log "filePath: " + filePath

    template = await fs.readFile(templatePath, "utf-8")        
    fileContent = mustache.render(template, {modules: coffeeModules})
    
    # log "\n - - - \nfileContent:\n" + fileContent
    await fs.writeFile(filePath, fileContent)

writeImportCoffee = (coffeeModules) ->
    log "writeCoffeeImportStyle"

    templatePath = pathModule.resolve(__dirname, "file-templates/import-template.coffee")
    fileName = "modules.coffee"
    filePath = pathModule.resolve(pathHandler.allmodulesPath,  fileName)
    # log "filePath: " + filePath

    template = await fs.readFile(templatePath, "utf-8")        
    fileContent = mustache.render(template, {modules: coffeeModules})
    
    # log "\n - - - \nfileContent:\n" + fileContent
    await fs.writeFile(filePath, fileContent)

writeStyl = (styleModules) ->
    log "writeStyl"

    templatePath = pathModule.resolve(__dirname, "file-templates/allstyles-template.styl")
    fileName = "modules.styl"
    filePath = pathModule.resolve(pathHandler.allmodulesPath,  fileName)
    # log "filePath: " + filePath

    template = await fs.readFile(templatePath, "utf-8")        
    fileContent = mustache.render(template, {modules: styleModules})
    
    # log "\n - - - \nfileContent:\n" + fileContent
    await fs.writeFile(filePath, fileContent)

checkForImportStyle = ->
    log "checkForImportStyle"
    packageJsonPath = pathHandler.getPackageJsonPath()
    packageJson = await fs.readFile(packageJsonPath, "utf-8")

    packageObject = JSON.parse(packageJson)
    type = packageObject.type
    log type

    switch type
        when "website" then return true
        when "app" then return true
        else return false
#endregion

#region exposed functions
allmodulesgenmodule.generate = (modules) ->
    log "allmodulesgenmodule.generate"

    hasImportStyle = await checkForImportStyle()

    if hasImportStyle then writeCoffee = writeImportCoffee
    else writeCoffee = writeRequireCoffee

    if modules.coffee && modules.coffee.length > 0
        await writeCoffee(modules.coffee)
    
    if modules.style && modules.style.length > 0
        await writeStyl(modules.style)
    
#endregion

module.exports = allmodulesgenmodule