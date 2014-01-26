auth = require '../lib/auth'

module.exports = (app) ->

  # Home route
  app.get '/', auth.none, (req, res) ->
    res.render 'index'#,
      #user: req.user ? JSON.stringify req.user : 'null'

