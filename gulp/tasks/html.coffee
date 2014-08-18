gulp = require 'gulp'

gulp.task 'html', () ->
  gulp.src(path.html)
  .pipe(size())
  .pipe(gulp.dest '_public')