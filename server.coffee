# monitoring with nodetime
if process.env.NODE_ENV == 'production'
  require('nodetime').profile(
    accountKey: "ENTER-A-VALID-KEY-HERE"
    appName: 'mean.coffee'
  )

# dependencies
config   = require './server/config/config'
logger   = require './server/config/logger'
express  = require 'express'
mongoose = require 'mongoose'
passport = require 'passport'
glob     = require 'glob'
path     = require 'path'

root_path = __dirname

# catch all uncaught exceptions
process.on 'uncaughtException', (err) ->
  logger.error 'Something very bad happened: ', err.message
  logger.error err.stack
  process.exit 1  # because now, you are in unpredictable state!

# watch and log any leak (a lot of false positive though)
memwatch = require 'memwatch'
memwatch.on 'leak', (d) -> logger.error "LEAK: #{JSON.stringify(d)}"

# bootstap db connection
db = mongoose.connect config.DBURL
logger.info "mongo connected to", config.DBURL

# exit on db connection error
mongoose.connection.on 'error', (err) ->
  logger.error "mongodb error: #{err}"
  process.exit 1

# retry 10 times on db connection lost
attempt = 1
mongoose.connection.on 'disconnected', () ->
  if attempt < 10
    logger.error "mongodb disconnected, trying to reconnect.."
    logger.info "mongodb reconnect, attempt num #{attempt}"
    attempt += 1
    db = mongoose.connect config.DBURL, opts
  else
    logger.error "mongodb disconnect, giving up!"

# bootstrap passport config
require('./server/config/passport')(passport)

# express configuration
app = require("./server/config/express")(passport, db, logger, root_path)
require('./server/config/globals')(app)

# bootstrap routes
require('./server/routes')(app)

# bootstrap routes based on *.route.coffee naming
# files = glob.sync 'server/**/*.route.{js,coffee}'
# for file in files when file.lastIndexOf("server/specs/", 0) isnt 0
#   logger.info "Found a route file, #{file} - requiring it"
#   require(path.join __dirname, file)(app)

# start the app
app.listen app.get('port'), ->
  logger.info "app server listening on port #{@address().port} in #{config.ENV} mode"

