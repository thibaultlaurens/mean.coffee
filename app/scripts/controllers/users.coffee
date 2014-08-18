app = require = '../app'
app.controller 'UserController', ['$scope', 'Global', ($scope, Global) ->
  $scope.global = Global
]
