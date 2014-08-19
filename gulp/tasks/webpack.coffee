gulp = require 'gulp'
gWebpack = require 'gulp-webpack'

# console.log require '../../webpack.conf.coffee'
gulp.task 'webpack', ->
  gulp.src [
    'app/scripts/app.coffee'
    'app/scripts/config.coffee'
    'app/scripts/**/*.coffee'
    'app/scripts/**/*.js'
    'app/styles/*.css'
    'app/styles/**/*.css'
  ]
  .pipe(gWebpack require '../../webpack.conf.coffee')
  .pipe(gulp.dest('_public/'))
