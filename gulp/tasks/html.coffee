gulp = require 'gulp'
size = require 'gulp-size'
path = require '../paths'

gulp.task 'html', () ->
  gulp.src(path.html)
  .pipe(size())
  .pipe(gulp.dest '_public')
