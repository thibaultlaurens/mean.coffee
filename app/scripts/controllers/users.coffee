app = require '../app.coffee'

module.exports = app.controller 'UserController', ['$scope', 'Global', ($scope, Global) ->
  $scope.global = Global
]
