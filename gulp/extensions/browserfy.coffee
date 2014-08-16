#Dependency object to make browserfy shim declaration easier and less terse
#https://github.com/thlorenz/browserify-shim
dep = class Dependency
  constructor: (@location, @exports)->

  dependsOn: (deps) =>
    return @ if !deps

    deps = [deps] unless _.isArray deps
    deps = deps.map (d) ->
      #clean dependencies incase theu are a Dependency Class of this type
      if d.dependsOn? and d.bfy?
        return d.bfy()
      return d

    @depends = if not @depends? then _.extends deps else _.extend(@depends, _.extends deps)

    @
  #output browserfy expected object
  bfy: =>
    obj = {}
    obj["#{@location}"] =
      exports: @exports
    obj["#{@location}"].depends = @depends if @depends
    return obj


module.exports = dep