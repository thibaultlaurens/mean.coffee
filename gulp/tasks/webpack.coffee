gulp = require 'gulp'
gWebpack = require 'gulp-webpack'


gulp.task 'webpack', ->
  gulp.src('app/scripts/app.coffee')
  .pipe(gWebpack require '../../webpack.conf.coffee')
  .pipe(gulp.dest('dist/'))