logger       = require '../config/logger'
auth         = require '../config/auth'
user_service = require './users.service'
express      = require 'express'
router       = express.Router()

router.get '/', auth.basic, (req, res) ->
  logger.info 'get all users'
  user_service.getUsers (err, users) ->
    res.send err, users

router.get '/:id', auth.basic, (req, res) ->
  id = req.params.id
  logger.info 'get user #{id}'
  user_service.getUser id, (err, user) ->
    res.send err, user

router.post '/signin', auth.none, (req, res) ->

router.post '/signup', auth.none, (req, res) ->

router.get '/signout', auth.basic, (req, res) ->
  req.logout()
  res.redirect('/')

module.exports = router
