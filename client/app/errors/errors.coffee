meanApp.config ($routeProvider) ->
  $routeProvider
    .when '/500',
        templateUrl: 'errors/500.tpl.html'
    .when '/404',
        templateUrl: 'errors/404.tpl.html'
    .otherwise
      redirectTo: '/404'
