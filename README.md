# gulp-swiffy

Converts SWF files with the Google Swiffy online service.

Uses the [swiffy-convert](https://github.com/blvz/swiffy-convert) module.

## Usage

```javascript
var gulp   = require('gulp'),
    swiffy = require('gulp-swiffy');

gulp.task('mytask', function() {
  return gulp.src('flash/*.swf')
  .pipe(swiffy()) // same as swiffy('html'); it can be also swiffy('json')
  .pipe(gulp.dest('swiffy/'));
});
```

Then run your task:

```bash
$ gulp mytask
```

You can see convertion warnings and errors [by setting the DEBUG
environment variable](https://github.com/visionmedia/debug#usage) to `swiffy`.
Example:

```bash
$ DEBUG=swiffy gulp mytask
```

Alternatively, all messages are accessible within the `file.data` object.
Example:

```javascript
var gulp    = require('gulp'),
    swiffy  = require('gulp-swiffy'),
    through = require('through2');

gulp.task('mytask', function() {
  return gulp.src('flash/*.swf')
  .pipe(swiffy()) // same as swiffy('html'); it can be also swiffy('json')
  .pipe(through.obj(function(file, enc, callback) {
    if (file.data.swiffy != null && file.data.swiffy.messages != null) {
      console.log('WARNINGS for file ' + file.path);
      file.data.swiffy.messages.forEach(function(message) {
        console.log('[ ' + message.type + ' ]', message.description);
      });
    }
    callback(null, file);
  }))
  .pipe(gulp.dest('swiffy/'));
});
```


## API

`swiffy(format, opts)`


### Format

Defaults to `'html'`.

#### HTML

Converts the SWF file to HTML, using Google Swiffy. Just like manually uploading
on the website, or converting with the Flash extension.

Example: `swiffy('html')`

#### JSON

After converting the SWF file, strips everything but the JSON data.

Example: `swiffy('json')`


### Options

#### maxConcurrency

The maximum number of files to be converted at the same time.  
Defaults to `10`.

Example: `swiffy('html', {maxConcurrency: 20})`
