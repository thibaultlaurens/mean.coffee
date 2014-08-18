gulp = require 'gulp'
uglify = require 'gulp-uglify'
coffee = require 'gulp-coffee'

gulp.task 'uglyscripts', () ->
  gulp.src(path.scripts)
  .pipe(coffee({bare: true}).on 'error', gutil.log)
  .pipe(concat 'app.min.js')
  .pipe(uglify())
  .pipe(size())
  .pipe(gulp.dest '_public/js')