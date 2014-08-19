'use strict'

window.$ = window.jQuery = require 'jquery'
require 'angular'
require 'angular-route'
require 'angular-cookies'
require 'angular-resource'
require 'angular-route'
require 'angular-bootstrap/ui-bootstrap-tpls.js' #angular-bootstrap

_ = require 'lodash'

require '../styles/common.css'
require 'bootstrap/dist/css/bootstrap.css'
require 'bootstrap/dist/js/bootstrap.js'

#console.log "ANGULAR: #{_.keys(angular)}"

app = window.angular.module 'meanApp', ['ngCookies', 'ngResource', 'ngRoute', 'ui.bootstrap']

module.exports = app
