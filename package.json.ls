name: 'gulp-swiffy'
version: '1.0.0'
description: 'Gulp plugin to convert SWF files with Google Swiffy.'
main: 'index.js'

keywords: <[ gulpplugin gulp adobe flash shockwave swf google swiffy canvas ]>
author: 'Rafael Belvederese'
license: 'MIT'

repository:
  type: 'git'
  url: 'https://github.com/blvz/gulp-swiffy.git'

  bugs:
    url: 'https://github.com/blvz/gulp-swiffy/issues'

engines:
  node: '>=0.11'

scripts:
  prepublish: 'make metadata'
  test: 'make test'

files: <[ index.js ]>

dependencies:
  debug:                 '^2.1.3'
  'swiffy-convert':      '^1.0.1'
  'through2-concurrent': '^1.0.0'

dev-dependencies:
  vows:                  '~0.8.1'
  'vows-at':             '~0.0.1'
  LiveScript:            '^1.3.1'
