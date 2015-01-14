module.exports = (app) ->
  # Mount module routes here
  app.use '/users', require './users'

  # end module routes

  # All undefined asset or api routes should return a 404
  app.route '/:url(api|auth|components|app|bower_components|assets)/*'
    .get (req, res) ->
      res.status 404
        .send 'Page not found. Sorry about that.'
