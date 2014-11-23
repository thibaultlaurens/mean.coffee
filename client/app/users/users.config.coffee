meanApp.config ($routeProvider) ->
  $routeProvider
    .when '/users',
      templateUrl: 'users/users.tpl.html'
      controller: 'UserCtrl'
