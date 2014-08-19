browserSync = require 'browser-sync'
gulp = require 'gulp'

gulp.task 'browserSync', ['build','express'], ->
  browserSync.init
    files: ['_public/**/*','app/**']
    proxy: "localhost:4000"
    port: 3000
