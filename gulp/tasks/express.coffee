gulp = require 'gulp'
#server = require 'gulp-express'
shell = require 'gulp-shell'

gulp.task "server", shell.task ['coffee server.coffee']


# gulp.task 'server', ['default'], ->
#   #start the server at the beginning of the task
#   server.run file: 'coffee server.coffee'
#
#   #restart the server when file changes
#   gulp.watch ['_public/**'], server.notify
#   gulp.watch [
#     'server.coffee'
#     'routes/**/*.coffee'
#   ], [server.run]
