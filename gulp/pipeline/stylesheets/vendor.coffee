pipe = require("../pipeInit").create()
_ = pipe._

bowerPath = 'bower_components/'

selfHosted = [].mapPath("lib/stylesheets/")

bower = [
  'bootstrap/dist/css/bootstrap.css'
  'bootstrap/dist/css/bootstrap-theme.css'
].mapPath bowerPath

pipeline = _([selfHosted, bower]).flatten()

module.exports = pipeline
