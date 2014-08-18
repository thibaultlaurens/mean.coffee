gulp = require 'gulp'
gWebpack = require 'gulp-webpack'

# console.log require '../../webpack.conf.coffee'
gulp.task 'webpack', ->
  gulp.src('app/scripts/app.coffee')
  .pipe(gWebpack require '../../webpack.conf.coffee')
  .pipe(gulp.dest('_public/'))
