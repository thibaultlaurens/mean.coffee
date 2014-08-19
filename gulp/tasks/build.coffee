gulp = require 'gulp'

gulp.task 'build', ['html','images'] #'vendor' might use vendor by gulp instead of bower and webpack
gulp.task 'scripts', ['build']
