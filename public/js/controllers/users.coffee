'use strict';

angular.module('mean.users').controller('UsersController',
  ['$scope', '$routeParams', '$location', 'Global', 'Articles', ($scope, $routeParams, $location, Global, Users) ->

    $scope.global = Global

    $scope.find = () ->
      Users.query (users) ->
        $scope.users = users


    $scope.findOne = () ->
      Users.get { articleId: $routeParams.articleId }, (user) ->
        $scope.user = user

  ])