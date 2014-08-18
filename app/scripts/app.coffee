'use strict'

angular = require 'angular'

app = angular.module 'meanApp', ['ngCookies', 'ngResource', 'ngRoute', 'ui.bootstrap']
app = require('./config.coffee')(app)

module.exports = app
