gulp = require 'gulp'
#server = require 'gulp-express'
shell = require 'gulp-shell'
nodemon = require 'gulp-nodemon'

# gulp.task "express", shell.task ['coffee server.coffee']

gulp.task "express", ->
  nodemon(script: "server.coffee")

gulp.task "server", ["browserSync"]
gulp.task 's', ['server']
