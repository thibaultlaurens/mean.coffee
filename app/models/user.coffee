passwordHash = require 'password-hash'
mongoose = require 'mongoose'
Schema = mongoose.Schema

User = new Schema(
  username :
    type: String
    index:
      unique: true
    required: true

  hashed_password:
    type: String
    required: true
)

User.virtual('password').set (password) ->
  options =
    algorithm: 'sha256',
    iterations: 1024,
    saltLength: 10
  @hashed_password = passwordHash.generate password, options

User.methods.authenticate = (plainText) ->
  passwordHash.verify(plainText, @hashed_password)

module.exports = mongoose.model('User', User)