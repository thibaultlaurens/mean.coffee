gulp              = require 'gulp'
sass              = require 'gulp-sass'
coffee            = require 'gulp-coffee'
concat            = require 'gulp-concat'
gutil             = require 'gulp-util'
rename            = require 'gulp-rename'
clean             = require 'gulp-clean'
gulpif            = require 'gulp-if'
karma           = require('karma').server

# Minification
uglify            = require 'gulp-uglify'
minifyHTML        = require 'gulp-minify-html'
minifyCSS         = require 'gulp-minify-css'
imagemin          = require 'gulp-imagemin'
pngcrush          = require 'imagemin-pngcrush'

# Angular Helpers
ngAnnotate        = require 'gulp-ng-annotate'
htmlify           = require 'gulp-angular-htmlify'

del               = require 'del'
flatten           = require 'gulp-flatten'
size              = require 'gulp-size'
livereload        = require 'gulp-livereload'

path =
  app:
    scripts: ["client/app/**/*.{coffee,js}", "client/app/**/*.{coffee,js}"] # All .js and .coffee files, starting with app.coffee or app.js
    styles: "client/app/**/*.{scss,sass,css}" # css and scss files
    bower: 'client/components'
    templates: "client/app/**/*.{html,jade}" # All html, jade, and markdown files used as templates within the app
    images: "client/app/images/*.{png,jpg,jpeg,gif,ico}" # All image files
    static: "client/app/static/*.*" # Any other static content such as the favicon

tasks = {}

gulp.task 'test', (done) ->
  karma.start
    configFile: __dirname + '/karma.conf.js'
    #singleRun: true
  , done

gulp.task 'scripts', tasks.scripts = () ->
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
gulp.task 'scripts:clean', ['clean'], tasks.scripts

gulp.task "styles", tasks.styles = ->
  sassstream = sass({
      errLogToConsole: true,
      sourceComments: 'normal'
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
gulp.task 'styles:clean', ['clean'], tasks.styles

gulp.task 'templates', tasks.templates = ->
  gulp.src path.app.templates
    .pipe(size())
    .pipe(gulp.dest('www'))
    .pipe(livereload())
gulp.task 'templates:clean', ['clean'], tasks.templates

gulp.task 'jquery', tasks.jquery = ->
  gulp.src('client/components/jquery/dist/jquery.min.js')
    .pipe(size())
    .pipe(gulp.dest('www/js'))
gulp.task 'jquery:clean', ['clean'], tasks.jquery

gulp.task 'bowerjs', tasks.bowerjs = ->
  gulp.src('client/components/**/*.min.js', !'client/components/jquery/dist/jquery.min.js')
    .pipe(flatten())
    .pipe(concat 'vendor.min.js')
    .pipe(size())
    .pipe(gulp.dest('www/js'))
gulp.task 'bowerjs:clean', ['clean'], tasks.bowerjs

gulp.task 'bowercss', tasks.bowercss = ->
  gulp.src('client/components/**/*.min.css')
    .pipe(flatten())
    .pipe(concat 'vendor.min.css')
    .pipe(size())
    .pipe(gulp.dest('www/css'))
gulp.task 'bowercss:clean', ['clean'], tasks.bowercss

gulp.task 'assets', tasks.assets = ->
  gulp.src(path.app.images)
    .pipe(imagemin({optimizationLevel: 5}))
    .pipe(size())
    .pipe(gulp.dest 'www/assets')
    .pipe(livereload())
gulp.task 'assets:clean', ['clean'], tasks.assets

gulp.task 'watch', () ->
  livereload.listen()
  gulp.watch path.app.scripts, ['scripts']
  gulp.watch path.app.styles, ['styles']
  gulp.watch path.app.bower, ['bowerjs', 'bowercss']
  gulp.watch path.app.templates, ['templates']
  gulp.watch path.app.images, ['images']

gulp.task 'clean', (cb) ->
  del(['www/**'], cb)

gulp.task 'default', ['build', 'watch']

gulp.task 'build', ['scripts:clean', 'styles:clean', 'templates:clean', 'jquery:clean', 'bowerjs:clean', 'bowercss:clean', 'assets:clean']
