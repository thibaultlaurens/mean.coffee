meanApp.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'main/main.tpl.html'
      controller: 'MainCtrl'

meanApp.controller 'MainCtrl', ($scope, Global) ->
  $scope.global = Global
