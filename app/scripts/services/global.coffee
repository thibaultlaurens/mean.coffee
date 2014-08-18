app = require = '../app'
#Global service for global variables
app.factory 'Global', [

  () ->
    _this = this
    _this._data =
      user: window.user
      authenticated: !! window.user
    return _this._data
]
