#Dependency object to make browserfy shim declaration easier and less terse
#https://github.com/thlorenz/browserify-shim
dep = class Dependency
  constructor:(@location,@exports)->

  dependsOn:(deps) =>
    deps = deps.map (d) ->
      #clean dependencies incase theu are a Dependency Class of this type
      if d.DependsOn and d.bfy
        return d.bfy()
      return d

    @depends = _.extends deps
    @
  #output browserfy expected object
  bfy:=>
    @location:
      exports: @exports
      depends: @depends


module.exports = dep