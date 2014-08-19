gulp = require 'gulp'
concat = require 'gulp-concat'

vendorPipe = require '../pipeline/scripts/vendor'

bower = 'bower_componenets'
gulp.task 'vendor', ->
  gulp.src(vendorPipe.pipeline)
  .pipe(concat("vendor.js"))
  .pipe(gulp.dest("_public/"))

  gulp.src(vendorCssPipe)
    .pipe(gulpif(/[.]scss$/, sass().on('error', log)))
    .pipe(ourUtils.onlyDirs(es))
    .pipe(concat(vendor.css()))
    .pipe(size(title: vendor.css()))
