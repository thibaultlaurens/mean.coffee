app = require = '../app'

app.controller 'MainController', ['$scope', 'Global', ($scope, Global) ->

  $scope.global = Global

]
