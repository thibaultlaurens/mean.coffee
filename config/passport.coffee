mongoose = require 'mongoose'
BasicStrategy = require('passport-http').BasicStrategy
User = require("../models/user")

module.exports = (passport) ->

  passport.use new BasicStrategy ({}), (username, password, done) ->
    User.findOne { username: username }, (err, user) ->
      if err then return done(err)
      if not user then return done(null, false)
      if not user.authenticate(password) then return done(null, false)
      return done(null, user)

  passport.serializeUser (user, done) ->
    done(null, user)

  passport.deserializeUser (user, done) ->
    done(null, user)