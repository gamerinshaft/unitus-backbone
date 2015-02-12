gulp = require 'gulp'
coffee = require 'gulp-coffee'
jade = require 'gulp-jade'
wrap = require 'gulp-wrap-amd'
sass = require 'gulp-sass'

gulp.task 'default', ->
  aa =
    '
    ∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃\n∃∃             ∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃   ∃∃∃∃∃∃∃   ∃∃∃∃             ∃∃∃      ∃∃∃      ∃∃\n∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃∃∃   ∃∃∃   ∃∃∃∃∃\n∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃     ∃∃∃     ∃∃∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃∃∃∃   ∃   ∃∃∃∃∃∃\n∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃             ∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃  ∃   ∃   ∃  ∃∃∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃∃∃∃       ∃∃∃∃∃∃\n∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃  ∃∃     ∃∃  ∃∃∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃∃∃    ∃    ∃∃∃∃∃\n∃∃∃∃∃∃∃   ∃∃∃∃∃∃∃∃∃    ∃∃∃∃∃    ∃∃∃∃             ∃∃∃∃  ∃∃∃   ∃∃∃  ∃∃∃∃             ∃∃∃      ∃∃∃      ∃∃\n∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃∃\n
    '
  console.log aa

printError = (error) ->
  console.log error.toString()
  @emit 'end'

gulp.task 'coffee', ->
  gulp
  .src 'coffeescripts/**/*.coffee'
  .pipe coffee bare: true
  .on 'error', printError
  .pipe gulp.dest 'js/lib/'

gulp.task 'sass', ->
  gulp
  .src 'scss/*.scss'
  .pipe sass errLogToConsole: true
  .pipe gulp.dest 'css'

gulp.task 'jade', ->
  gulp
  .src 'templates/**/*.jade'
  .pipe jade client: true
  .pipe wrap
    deps: ['jade']
    params: ['jade']
  .on 'error', printError
  .pipe gulp.dest 'js/lib/templates/'

  gulp
  .src 'index.jade'
  .pipe jade pretty: true
  .on 'error', printError
  .pipe gulp.dest './'

gulp.task 'watch', ->
  gulp.watch 'coffeescripts/**', ['coffee']
  gulp.watch ['index.jade', 'templates/**'], ['jade']
  gulp.watch 'scss/**', ['sass']