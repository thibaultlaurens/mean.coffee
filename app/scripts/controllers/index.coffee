'use strict'

angular.module('meanApp.controller').controller('IndexController', ['$scope', 'Global', ($scope, Global) ->
  $scope.global = Global
])