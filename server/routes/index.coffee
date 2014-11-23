fs = require 'fs'
path = require 'path'

module.exports = (app) ->
  fs.readdirSync(app.settings.routes).forEach((file) ->
    filePath = path.join app.settings.routes, file
    unless filePath is __filename
      baseFilename = path.basename file, path.extname(file)
      route = path.join app.settings.routes, baseFilename
      require(route)(app)
  )