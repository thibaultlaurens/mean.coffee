_ = require 'lodash'

_.extends = (arrayOfObjectsToCombine)->
  _.reduce arrayOfObjectsToCombine, (combined, toAdd)->
    _.extend(combined, toAdd)
  , {} #starting point empty object

global._ = _