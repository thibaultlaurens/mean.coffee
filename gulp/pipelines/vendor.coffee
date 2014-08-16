dep = require 'browserify-shim-dependency'
bower = '../../app/components/'

$ = new dep "#{bower}jquery/dist/jquery.js", '$'
angular = new dep("#{bower}angular/angular.js", 'angular').dependsOn $

deps = [
  $
  angular
  new dep "#{bower}bootstrap/dist/bootstrap.js", 'bootstrap'
  new dep("#{bower}lodash/dist/lodash.js", '_')
]

angularUi = [
  new dep("#{bower}angular-bootstrap/ui-bootstrap.js", 'angular-bootstrap').dependsOn angular
  new dep("#{bower}angular-ui-utils/ui-utils.js", 'angular-ui-utils').dependsOn angular
]

angularDeps = [
  'angular-mocks'
  'angular-resource'
  'angular-route'
].map (d) ->
  new dep("#{bower}angular-#{d}/angular-#{d}.js", "angular-#{d}").dependsOn angular


module.exports = dep.combine deps.concat(angularUi).concat(angularDeps)
