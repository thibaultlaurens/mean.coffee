fs = require 'fs'
path = require 'path'

module.exports = (app) ->
  fs.readdirSync(app.settings.models).forEach((file) ->
    filePath = path.join app.settings.models, file
    unless filePath is __filename
      baseFilename = path.basename file, path.extname(file)
      model = path.join app.settings.models, baseFilename
      require(model)
  )