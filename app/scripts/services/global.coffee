app = require '../app.coffee'
#Global service for global variables

module.exports =
  app.factory 'Global', [
    ->
      _this = this
      _this._data =
        user: window.user
        authenticated: !! window.user
      return _this._data
  ]
