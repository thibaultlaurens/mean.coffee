gulp              = require 'gulp'
sass              = require 'gulp-sass'
coffee            = require 'gulp-coffee'
concat            = require 'gulp-concat'
gutil             = require 'gulp-util'
rename            = require 'gulp-rename'
clean             = require 'gulp-clean'
gulpif            = require 'gulp-if'

# Minification
uglify            = require 'gulp-uglify'
minifyHTML        = require 'gulp-minify-html'
minifyCSS         = require 'gulp-minify-css'
imagemin          = require 'gulp-imagemin'
pngcrush          = require 'imagemin-pngcrush'

# Angular Helpers
ngAnnotate        = require 'gulp-ng-annotate'
htmlify           = require 'gulp-angular-htmlify'

rimraf            = require 'gulp-rimraf'
flatten           = require 'gulp-flatten'
size              = require 'gulp-size'
livereload        = require 'gulp-livereload'

path =
  app:
    scripts: ["client/app/scripts/*.{coffee,js}", "client/app/scripts/**/*.{coffee,js}"] # All .js and .coffee files, starting with app.coffee or app.js
    styles: "client/app/styles/**/*.{scss,sass,css}" # css and scss files
    bower: 'client/components'
    templates: "client/app/templates/**/*.{html,jade,md,markdown}" # All html, jade, and markdown files used as templates within the app
    images: "client/app/images/*.{png,jpg,jpeg,gif,ico}" # All image files
    static: "client/app/static/*.*" # Any other static content such as the favicon

gulp.task 'scripts', () ->
  coffeestream = coffee({bare: true})
  coffeestream.on("error", gutil.log)
  gulp.src path.app.scripts
    .pipe(gulpif(/[.]coffee$/, coffeestream))
    .pipe(ngAnnotate())
    .pipe(concat("app.js"))
    .pipe(size())
    .pipe(gulp.dest("www/js"))
    .pipe(uglify())
    .pipe(rename({extname: ".min.js"}))
    .pipe(size())
    .pipe(gulp.dest "www/js")
    .pipe(livereload())

gulp.task "styles", ->
  sassstream = sass({
      sourcemap: false,
      unixNewlines: true,
      style: 'nested',
      debugInfo: false,
      quiet: false,
      lineNumbers: true,
      bundleExec: true
    })
  sassstream.on("error", gutil.log)

  gulp.src path.app.styles
    .pipe(gulpif(/[.]sass|scss$/, sassstream))
    .pipe(concat 'app.css')
    .pipe(size())
    .pipe(gulp.dest "www/css")
    .pipe(minifyCSS())
    .pipe(rename({extname: ".min.css"}))
    .pipe(size())
    .pipe(gulp.dest "www/css")
    .pipe(livereload())

gulp.task 'templates', ->
  gulp.src path.app.templates
    .pipe(size())
    .pipe(gulp.dest('www'))
    .pipe(livereload())

gulp.task 'jquery', () ->
  gulp.src('client/components/jquery/jquery.min.js')
    .pipe(size())
    .pipe(gulp.dest('www/js'))

gulp.task 'bowerjs', () ->
  gulp.src('client/components/**/*.min.js', !'client/components/jquery/jquery.min.js')
    .pipe(flatten())
    .pipe(concat 'vendor.min.js')
    .pipe(size())
    .pipe(gulp.dest('www/js'))

gulp.task 'bowercss', () ->
  gulp.src('client/components/**/*.min.css')
    .pipe(flatten())
    .pipe(concat 'vendor.min.css')
    .pipe(size())
    .pipe(gulp.dest('www/css'))

gulp.task 'assets', () ->
  gulp.src(path.app.images)
    .pipe(imagemin({optimizationLevel: 5}))
    .pipe(size())
    .pipe(gulp.dest 'www/assets')
    .pipe(livereload())

gulp.task 'ngroute', () ->
  gulp.src('client/components/angular-route/angular-route.min.js')
  .pipe(flatten())
  .pipe(concat 'ngroute.min.js')
  .pipe(size())
  .pipe(gulp.dest('www/js'))

gulp.task 'watch', () ->
  livereload.listen()
  gulp.watch path.app.scripts, ['scripts']
  gulp.watch path.app.styles, ['styles']
  gulp.watch path.app.bower, ['bowerjs', 'bowercss']
  gulp.watch path.app.templates, ['templates']
  gulp.watch path.app.images, ['images']

gulp.task 'clean', () ->
  gulp.src('www', { read: false })
    .pipe(rimraf())


gulp.task 'default', ['build', 'watch']

gulp.task 'build', ['clean', 'scripts', 'styles', 'templates', 'jquery', 'bowerjs', 'bowercss', 'assets', 'ngroute']
