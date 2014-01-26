logger = require '../lib/logger'

mongoose = require 'mongoose'
User = mongoose.model 'User'

module.exports =

  getUsers: (cb) ->
    User.find {}, (err, user) -> cb err, user

  getUser: (id, cb) ->
    User.findOne {_id: id}, (err, user) -> cb err, user

  createUser: (name, pwd, cb) ->
    user = new User
      username: name
      password: pwd
    user.save (err) -> cb err, user






