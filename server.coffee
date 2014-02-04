if process.env.NODE_ENV == 'production'
  require('nodetime').profile(
    accountKey: ""
    appName: 'mean.coffee'
  )

config = require './lib/config'
logger = require './lib/logger'

process.on 'uncaughtException', (err) ->
  logger.error 'Something very bad happened: ', err.message
  logger.error err.stack
  process.exit 1  # because now, you are in unpredictable state!

memwatch = require 'memwatch'
memwatch.on 'leak', (d) ->
  logger.error "LEAK: #{JSON.stringify(d)}"

express = require 'express'
app = express()
app.logger = logger

mongoose = require 'mongoose'
mongoose.connect config.DBURL
logger.info "mongo connected to", config.DBURL

mongoStore = require('connect-mongo')(express)
helmet = require 'helmet'
passport = require 'passport'
multipart = require 'connect-multiparty'

#app.set 'showStackError', true
#app.locals.pretty = true
###
app.use express.compress( # Should be placed before express.static to ensure that all assets and data are compressed (utilize bandwidth)
  filter: (req, res) ->
    return (/json|text|javascript|css/).test(res.getHeader('Content-Type'))
  , level: 9 # Levels are specified in a range of 0 to 9, where-as 0 is no compression and 9 is best compression, but slowest
)
###

app.configure ->

  app.set 'port', config.PORT
  app.set 'routes', __dirname + '/routes/'
  app.set 'models', __dirname + '/models/'
  app.set 'config', config

  app.use helmet.xframe()
  app.use helmet.iexss()
  app.use helmet.contentTypeOptions()
  app.use helmet.cacheControl()

  app.use express.json()
  app.use express.urlencoded()
  app.use multipart()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use passport.initialize()
  app.use express.session({
    store: new mongoStore({
      url: config.DBURL
    }),
    secret: config.COOKIE_SECRET,
    cookie: {httpOnly: true, secure: true}
  })
  ### todo: bind this to angular frontend
  if process.env.NODE_ENV == 'production'
    app.use express.csrf()
    app.use (req, res, next) ->
      res.locals.csrftoken = req.csrfToken()
      next()
  ###
  app.use express.compress()
  app.use app.router
  app.use express.favicon()
  app.use express.static __dirname + '/_public'

require('./models')(app)
require('./lib/auth_provider').configure()
require('./routes')(app)

app.listen app.get('port'), ->
  logger.info "mean.coffee server listening on port #{@address().port} in #{config.ENV} mode"

