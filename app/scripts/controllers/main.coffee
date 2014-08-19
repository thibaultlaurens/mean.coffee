app = require '../app.coffee'

module.exports = app.controller 'MainController', ['$scope', 'Global', ($scope, Global) ->
  $scope.global = Global
]
