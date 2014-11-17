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

rimraf = require 'gulp-rimraf'
flatten = require 'gulp-flatten'
size = require 'gulp-size'

path =
  app:
    scripts: ["app/scripts/*.{coffee,js}", "app/scripts/**/*.{coffee,js}"] # All .js and .coffee files, starting with app.coffee or app.js
    styles: "app/styles/**/*.{scss,sass,css}" # css and scss files
    bower: 'app/components'
    templates: "app/templates/**/*.{html,jade,md,markdown}" # All html, jade, and markdown files used as templates within the app
    images: "app/images/*.{png,jpg,jpeg,gif}" # All image files
    static: "app/static/*.*" # Any other static content such as the favicon

gulp.task 'scripts', () ->
  coffeestream = coffee({bare: true})
  coffeestream.on("error", gutil.log)
  gulp.src path.app.scripts
    .pipe(gulpif(/[.]coffee$/, coffeestream))
    .pipe(ngAnnotate())
    .pipe(concat("app.js"))
    .pipe(size())
    .pipe(gulp.dest("_public/js"))
    .pipe(uglify())
    .pipe(rename({extname: ".min.js"}))
    .pipe(size())
    .pipe(gulp.dest "_public/js")

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
    .pipe(gulp.dest "_public/css")
    .pipe(minifyCSS())
    .pipe(rename({extname: ".min.css"}))
    .pipe(size())
    .pipe(gulp.dest "_public/css")

gulp.task 'templates', ->
  gulp.src path.app.templates
    .pipe(size())
    .pipe(gulp.dest('_public'))

gulp.task 'jquery', () ->
  gulp.src('app/components/jquery/jquery.min.js')
    .pipe(size())
    .pipe(gulp.dest('_public/js'))

gulp.task 'bowerjs', () ->
  gulp.src('app/components/**/*.min.js', !'app/components/jquery/jquery.min.js')
    .pipe(flatten())
    .pipe(concat 'vendor.min.js')
    .pipe(size())
    .pipe(gulp.dest('_public/js'))

gulp.task 'bowercss', () ->
  gulp.src('app/components/**/*.min.css')
    .pipe(flatten())
    .pipe(concat 'vendor.min.css')
    .pipe(size())
    .pipe(gulp.dest('_public/css'))

gulp.task 'assets', () ->
  gulp.src(path.app.images)
    .pipe(imagemin({optimizationLevel: 5}))
    .pipe(size())
    .pipe(gulp.dest '_public/assets')

gulp.task 'ngroute', () ->
  gulp.src('app/components/angular-route/angular-route.min.js')
  .pipe(flatten())
  .pipe(concat 'ngroute.min.js')
  .pipe(size())
  .pipe(gulp.dest('_public/js'))

gulp.task 'watch', () ->
  gulp.watch path.app.scripts, ['scripts']
  gulp.watch path.app.styles, ['styles']
  gulp.watch path.app.bower, ['bowerjs', 'bowercss']
  gulp.watch path.app.app.templates, ['templates']
  gulp.watch path.app.images, ['images']

gulp.task 'clean', () ->
  gulp.src('_public', { read: false })
    .pipe(rimraf())


gulp.task 'default', ['scripts', 'styles', 'templates', 'jquery', 'bowerjs', 'bowercss', 'assets', 'ngroute']

gulp.task 'dev', ['default', 'watch']

gulp.task 'build', ['clean', 'default']
