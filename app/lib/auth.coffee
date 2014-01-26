passport = require("passport")

module.exports =

  none: (req, res, next) ->
    next()

  basic: passport.authenticate('basic', { session: false })






