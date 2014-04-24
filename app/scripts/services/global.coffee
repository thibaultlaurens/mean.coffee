#Global service for global variables
meanApp.factory 'Global', [

  () ->
    _this = this
    _this._data =
      user: window.user
      authenticated: !! window.user
    return _this._data

]
