path = require 'path'
config = require './config'
express = require 'express'

# express midlewares
helmet = require 'helmet'
multipart = require 'connect-multiparty'
session = require 'express-session'
sessionStore = require('connect-mongo')({session: session})
compress = require 'compression'
bodyParser = require 'body-parser'
favicon = require 'static-favicon'
cookieParser = require 'cookie-parser'
methodOverride = require 'method-override'
serveStatic = require 'serve-static'
errorHandler = require 'errorhandler'

module.exports = (passport, db, logger, root_path) ->

  app = express()

  app.logger = logger

  # set port, routes, models and config paths
  app.set 'port', config.PORT
  app.set 'routes', root_path + '/routes/'
  app.set 'models', root_path + '/data_access/models/'
  app.set 'config', config

  # security headers
  app.use helmet.xframe()
  app.use helmet.iexss()
  app.use helmet.contentTypeOptions()
  app.use helmet.cacheControl()

  # ensure all assets and data are compressed - above static
  app.use compress()

  # setting the favicon and static folder
  app.use favicon path.join root_path, '/_public/assets/favicon.ico'
  app.use serveStatic path.join root_path, '_public'

  # cookie parser - above session
  app.use cookieParser config.COOKIE_SECRET

  # body parsing middleware - above methodOverride()
  app.use bodyParser()
  app.use multipart()
  app.use methodOverride()

  # session store (mongodb)
  app.use session
    secret: config.COOKIE_SECRET
    maxAge: 60 * 60 * 1000
    store: new sessionStore
      db: db.connection.db
      clear_interval: 60 * 60

  # let passport manage sessions
  app.use passport.initialize()
  app.use passport.session()

  # bootstrap routes
  require("../routes")(app)

  app.use (err, req, res, next) ->
    logger.error err.toString()
    next()

  if config.ENV is 'development' then  app.use errorHandler { dumpExceptions: true, showStack: true }

  return app

