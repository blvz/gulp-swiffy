name: \gulp-swiffy
version: \0.1.2
description: 'Gulp plugin to convert SWF files with Google Swiffy.'
main: \index.js

keywords: <[ gulpplugin gulp adobe flash shockwave swf google swiffy canvas ]>
author: 'Rafael Belvederese'
license: \MIT

repository:
  type: \git
  url: \https://github.com/blvz/gulp-swiffy.git

  bugs:
    url: \https://github.com/blvz/gulp-swiffy/issues

dependencies:
  request    : \^2.51.0
  through2   :  \^0.6.3
  \gulp-util :  \^2.2.0

devDependencies:
  vows       : \~0.8.1
  \vows-at   : \~0.0.1
  LiveScript : \^1.3.1

scripts:
  test: 'make test'
