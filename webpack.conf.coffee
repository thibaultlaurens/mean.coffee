webpack = require 'webpack'

module.exports =
  resolve:
    modulesDirectories: ['bower_components']#omitting node_modules on purpose (for backend)
  module:
    loaders: [
      # Exports Angular
      { test: /[\/]angular\.js$/, loader: "exports?angular" }
      { test: /\.css$/, loader: 'style!css' }
      { test: /\.styl$/, loader: 'style!css!stylus' }
      { test: /\.scss$/, loader: "style!css!sass?outputStyle=expanded"}
      { test: /\.coffee$/, loader: 'coffee' }
      { test: /\.png/, loader: 'url?limit=100000&minetype=image/png' }
      { test: /\.jpg/, loader: 'file' }
      { test: /\.woff$/, loader: "url?prefix=font/&limit=5000&mimetype=application/font-woff" }
      { test: /\.ttf$/, loader: "file?prefix=font/" }
      { test: /\.eot$/, loader: "file?prefix=font/" }
      { test: /\.svg$/, loader: "file?prefix=font/" }
    ]
    plugins:
       new webpack.ResolverPlugin([
            new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
        ])
