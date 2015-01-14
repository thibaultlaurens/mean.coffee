meanApp.config ($stateProvider) ->
  $stateProvider
    .state 'users',
      url: '/users',
      templateUrl: 'users/users.tpl.html'
      controller: 'UserCtrl'
