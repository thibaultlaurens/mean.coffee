webpack = require 'webpack'
HtmlWebpackPlugin = require 'html-webpack-plugin'

module.exports =
  watch:true
  verbose:true
  devtool: '#source-map'#'#inline-source-map'
  output:
    # filename: 'js/bundle.js'
    filename: "js/[name].wp.js"
    chunkFilename: "js/[id].wp.js"
  resolve:
    modulesDirectories: ['bower_components']
  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"]))
    new HtmlWebpackPlugin
      template: 'app/html/index.html'
    ]
  module:
    loaders: [
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
