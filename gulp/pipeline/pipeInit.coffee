###
Purpose is to contain all the pipeline bloat that is common throughout
javascript and css pipeline definitions.
###
_ = require 'lodash'
log = require("util").log
toob = "========"
fs = require 'fs'
mkdir = require 'mkdirp'
through = require 'through2'

GLOBAL.Array.prototype.mapPath = (path, hasStar = true) ->
  @map (f) ->
    p = path + f
    if hasStar
      p += "*"
    p

class Pipeline
  constructor:(@mappedPipe = []) ->
  paths:
    stylesheets : "app/assets/stylesheets/"
    javascripts : "app/assets/javascripts/"
  _ : _
  log : log
  toob: toob
  logToob: (str, array) ->
    if array
      log array
      log "#{toob} Begin Pipeline #{str} #{toob}"
      array.forEach (p) ->
        log p
      log "#{toob} END Pipeline #{str} #{toob}"
    else
      log "#{toob} #{str} #{toob}"

  #using through2 allows us to wrap the conglomerate of streams into one, therefore we can save just once and not for each matching file
  #this allows us to have a cb and notify the stream when we are actually done saving or failed saving the file
  #THROUGH2 is the magic that makes saving the pipeline consistent!!! SO this is IMPORTANT!
  saveJSON: (fileName,destination = "dist/assets/json/",doLog, pipeline, isAsset = true) =>
    through.obj (file, enc, cb) ->
      if (file.isNull())#shamelessly copied from gulp-size
        @push(file)
        return cb()
      if file.isStream()
        @emit('error', new gutil.PluginError('gulp-size', 'Streaming not supported'))
        return cb()
      @push file
      cb()
    , (cb) => #do the real work of this function
      pipeline = @mappedPipe unless pipeline
      pipeline = _(pipeline).uniq (p) -> p #strip dups
      log "######## #{pipeline} #############" if doLog
      # new line for every json item
      #have the assets be looked up via "assets directory for nginx"
      if isAsset
        pipeline = pipeline.map (p) ->
          if p.contains("assets/") then p else "/assets/" + p
      jsonStr = JSON.stringify(pipeline).replace(/,/g,',\n')
  #    log "######## JSON: #{jsonStr} #############" if doLog
      dest = destination + fileName + ".json"
      mkdir('dist/assets/json',() ->)
  #    log "post mkdir" if doLog
      fs.unlink(dest, ->) #delete old pipe if it exists
  #    log "post unlink" if doLog
      fs.writeFile dest, jsonStr, (err) ->
        log "callback save" if doLog
        if err
          log "failed to save #{dest} with error: #{err}"
          cb()
        else
          log "The #{dest} file was saved!"
          cb()
        return

module.exports = create: -> new Pipeline()
