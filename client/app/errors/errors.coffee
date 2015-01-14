meanApp.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/404'
  $stateProvider
    .state '500',
        url: '/500'
        templateUrl: 'errors/500.tpl.html'
    .state '404',
        url: '/404'
        templateUrl: 'errors/404.tpl.html'
