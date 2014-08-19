pipe = require("../pipeInit").create()
_ = pipe._

scriptPath = "lib/scripts/"
bowerPath = "bower_components/"

selfHosted = ([]).mapPath scriptPath

angularUi = [
  'angular-bootstrap/ui-bootstrap.js'
  'angular-ui-utils/ui-utils.js'
 ]

angular = [
  'mocks'
  'resource'
  'route'
].map((d) ->
   "angular-#{d}/angular-#{d}.js"
).mapPath bowerPath

bower = [
  'jquery/dist/jquery.js'
  'bootstrap/dist/js/bootstrap.js'
  'lodash/dist/lodash.js'
].mapPath bowerPath

pipeline = _([selfHosted, bower, angular]).flatten()
#pipe.logToob "Vendor", pipeline
module.exports = pipeline
