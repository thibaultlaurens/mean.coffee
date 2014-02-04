'use strict'

#Setting up route
angular.module('meanApp').config ['$routeProvider',
  ($routeProvider) ->
        $routeProvider
          .when '/users',
            templateUrl: 'views/users.html'
          .when '/',
            templateUrl: 'views/main.html'
            controller: 'MainController'
          .when '/500',
              templateUrl: 'views/500.html'
          .when '/404',
              templateUrl: 'views/404.html'
          .otherwise
            redirectTo: '/404'
]

#Setting HTML5 Location Mode
angular.module('mean.coffee').config ['$locationProvider',

  ($locationProvider) ->
    $locationProvider.hashPrefix('!')

]