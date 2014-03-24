fs = require 'fs'
path = require 'path'

module.exports = () ->

  fs.readdirSync(__dirname).forEach (file) ->
    filePath = path.join __dirname, file
    unless filePath is __filename
      baseFilename = path.basename file, path.extname(file)
      model = path.join __dirname, baseFilename
      require(model)