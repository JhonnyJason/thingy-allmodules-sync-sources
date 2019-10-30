debugmodule = {name: "debugmodule"}

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    # allmodulesgenmodule: true
    # cliargumentsmodule: true
    # configmodule: true
    # syncprocessmodule: true
    # modulesearchmodule: true
    # pathhandlermodule: true
    # startupmodule: true
    # utilmodule: true

#region exposed variables

module.exports = debugmodule