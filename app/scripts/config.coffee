#Setting up route
meanApp.config ['$routeProvider',
  ($routeProvider) ->
        $routeProvider
          .when '/users',
            templateUrl: 'views/users.html'
            controller: 'UserController'
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
#meanApp.config ['$locationProvider',

  #($locationProvider) -> $locationProvider.html5Mode(true)

#]