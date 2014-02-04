'use strict'

#Global service for global variables
angular.module('meanApp.system').factory 'Global', [

  () ->
    _this = this
    _this._data =
      user: window.user
      authenticated: !! window.user
    return _this._data

]
