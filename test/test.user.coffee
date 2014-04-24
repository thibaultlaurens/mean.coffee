config = require '../config/config'
mongoose = require 'mongoose'

require('../models')()
user_service = require '../services/service.user'

should = require('chai').should()


describe "Users", () ->

  before (done) -> mongoose.connect config.DBURLTEST, () -> done()
  currentUser = null

  it "creates a new user", (done) ->
    user_service.createUser "test@test.com", "password", (err, user) ->
      should.not.exist err
      should.exist user
      user.should.be.an 'object'
      user.username.should.equal "test@test.com"
      currentUser = user
      done()

  it "retrieves by id", (done) ->
    user_service.getUser currentUser.id, (err, user) ->
      should.not.exist err
      should.exist user
      user.should.be.an 'object'
      user.id.should.equal currentUser.id
      done()

  it "retrieves them all", (done) ->
    user_service.getUsers (err, users) ->
      should.not.exist err
      should.exist users
      users.should.be.an('array').with.length(1)
      done()

  it "deletes a user", (done) ->
    user_service.deleteUser currentUser.id, (err, user) ->
      should.not.exist err
      should.exist user
      user.should.be.an 'object'
      user.id.should.equal currentUser.id
      done()


