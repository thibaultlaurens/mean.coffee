changed = require 'gulp-changed'
gulp = require 'gulp'
imagemin = require 'gulp-imagemin'

dest = './_public/assets'

gulp.task 'images', ->
  # Ignore unchanged files
  # Optimize
  gulp.src('app/assets/**')
  .pipe(changed(dest))
  .pipe(imagemin())
  .pipe gulp.dest(dest)


#gulp.task 'assets', () ->
#  gulp.src(path.assets)
#  .pipe(imagemin({optimizationLevel: 5}))
#  .pipe(size())
#  .pipe(gulp.dest '_public/assets')
