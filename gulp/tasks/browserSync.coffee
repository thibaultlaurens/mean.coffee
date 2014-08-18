browserSync = require 'browser-sync'
gulp = require 'gulp'

gulp.task 'browserSync', ['build'], ->
  browserSync.init proxy: "localhost:3000"
