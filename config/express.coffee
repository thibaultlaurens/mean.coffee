path = require 'path'
config = require './config'
express = require 'express'
mongoStore = require('connect-mongo')(express)
helmet = require 'helmet'
multipart = require 'connect-multiparty'

module.exports = (app, passport, db, logger, root_path) ->

  app.logger = logger

  # custom session middleware
  sessionMiddleware =  express.session
    secret: config.COOKIE_SECRET
    cookie:
      httpOnly: true
      secure: true
    store: new mongoStore
      db: db.connection.db


  app.configure ->

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

    # cookie parser - above session
    app.use express.cookieParser()

    # body parsing middleware - above methodOverride()
    app.use express.urlencoded()
    app.use express.json()
    app.use multipart()
    app.use express.methodOverride()

    # unauthenticated session only
    app.use (req, res, next) ->
      if req.headers.authorization then return next()
      return sessionMiddleware req, res, next

    # authenticated session managed by passport
    app.use passport.initialize()
    app.use passport.session()

    app.use app.router

    # ensure all assets and data are compressed - above express.static
    app.use express.compress()

    # setting the favicon and static folder
    app.use express.favicon path.join root_path, '/_public/assets/favicon.ico'
    app.use express.static path.join root_path, '_public'

    app.use (err, req, res, next) ->
      logger.error err.toString()
      next()

    if config.ENV is 'development' then  app.use express.errorHandler { dumpExceptions: true, showStack: true }