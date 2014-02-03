'use strict'

#Setting up route
angular.module('mean').config ['$routeProvider',
  ($routeProvider) ->
        $routeProvider
          .when '/users',
            templateUrl: 'views/users/list.html'
          .when '/users/:userId',
            templateUrl: 'views/users/view.html'
          .when '/',
            templateUrl: 'views/index.html'
          .otherwise
          redirectTo: '/'
]

#Setting HTML5 Location Mode
angular.module('mean').config ['$locationProvider',

  ($locationProvider) ->
    $locationProvider.hashPrefix('!')

]