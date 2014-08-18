browserSync = require 'browser-sync'
gulp = require 'gulp'

gulp.task 'browserSync', ['express'], ->
  browserSync.init
    files: ['_public/**/*']
    proxy: "localhost:4000"
    port: 3000
