'use strict'

angular.module('meanApp.controller').controller('MainController', ['$scope', 'Global', ($scope, Global) ->
  $scope.global = Global
])