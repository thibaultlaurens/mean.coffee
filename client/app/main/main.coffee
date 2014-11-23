meanApp.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'main/main.tpl.html'
      controller: 'MainController'

meanApp.controller 'MainController', ($scope, Global) ->
  $scope.global = Global
