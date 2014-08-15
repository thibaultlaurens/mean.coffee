dep = require '../dependency'
bower = '../../app/components/'

$ = new dep "#{bower}jquery/dist/jquery.js", '$'
bootstrap = new dep "#{bower}bootstrap/dist/bootstrap.js" ,'bootstrap'
angular = new dep("#{bower}angular/angular.js", 'angular').dependsOn $

dependencies = _.extends $,bootstrap,angular

module.exports = dependencies
