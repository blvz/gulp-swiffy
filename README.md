# gulp-swiffy

Converts SWF files with the Google Swiffy online service.

## Usage

```javascript
var swiffy = require('gulp-swiffy');

gulp.task('swiffy', function() {
  gulp.src('flash/*.swf')
    .pipe(swiffy()) // same as swiffy('html'); it can be also swiffy('json')
  .pipe(gulp.dest('swiffy/'));
});
```

## API

### swiffy(format)

#### HTML

Converts the SWF file to HTML, using Google Swiffy. Just like manually uploading
on the website, or converting with the Flash extension.

#### JSON

After converting the SWF file, strips everything but the JSON data.
