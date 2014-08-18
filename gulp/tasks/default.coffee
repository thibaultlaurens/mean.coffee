gulp = require 'gulp'
help = require('gulp-help')(gulp)
#help = require 'gulp-task-listing'
clean = require 'gulp-rimraf'

gulp.task 'default', ['clean','build','watch']

#gulp.task('help', help.withFilters(/:/))

gulp.task 'clean', () ->
  gulp.src('_public', { read: false })
  .pipe(clean())



#concat = require 'gulp-concat'
#
#flatten = require 'gulp-flatten'
#minifycss = require 'gulp-minify-css'
#size = require 'gulp-size'
#
#
#gulp.task 'ngroute', () ->
#  gulp.src('app/components/angular-route/angular-route.min.js')
#  .pipe(flatten())
#  .pipe(concat 'ngroute.min.js')
#  .pipe(size())
#  .pipe(gulp.dest('_public/js'))
