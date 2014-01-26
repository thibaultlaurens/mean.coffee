path = require 'path'
logger = require '../lib/logger'
auth = require '../lib/auth'

user_service = require '../services/service.user'


module.exports = (app) ->

  app.get "/users", auth.basic, (req, res) ->
    logger.info "get all users"
    user_service.getUsers (err, users) ->
      help.send err, users, res

  app.get "/users/:id", auth.basic, (req, res) ->
    id = req.params.id
    logger.info "get user #{id}"
    user_service.getUser id, (err, user) ->
      help.send err, user, res

  app.post '/signin', auth.none, (req, res) ->

  app.post '/signup', auth.none, (req, res) ->

  app.get '/signout', auth.basic, (req, res) ->
    req.logout()
    res.redirect('/')
