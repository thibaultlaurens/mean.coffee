meanApp.config ($stateProvider) ->
  $stateProvider
    .state 'main',
      url: ''
      templateUrl: 'main/main.tpl.html'
      controller: 'MainCtrl'

meanApp.controller 'MainCtrl', ($scope, Global) ->
  $scope.global = Global
