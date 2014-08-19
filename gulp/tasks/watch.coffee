# Notes:
#   - gulp/tasks/browserify.js handles js recompiling with watchify
#   - gulp/tasks/browserSync.js automatically reloads any files
#     that change within the directory it's serving from
#
gulp = require 'gulp'
path = require '../paths'

gulp.task 'setWatch', ->
  global.isWatching = true

gulp.task 'watch', ['setWatch','browserSync'], ->
  gulp.watch [path.scripts,path.styles,path.bower,path.assets], ['webpack','build']
  gulp.watch path.html, ['html']
