require! {
  fs
  vows
  'vows-at': at
  '../index': plugin
  'gulp-util': {File}
}

function convert fmt, file, cb
  p = plugin fmt
  contents = ''
  p.on \data (data) -> contents += data.contents.to-string!
  p.on \end ~> cb null file, contents
  p.write file
  p.end!

describe = vows~describe

fixtures = do
  swf:  fs.read-file-sync "#__dirname/fixtures/example1.swf"
  html: String fs.read-file-sync "#__dirname/fixtures/example1.swf.html"
  json: String fs.read-file-sync "#__dirname/fixtures/example1.swf.json"

describe 'gulp-swiffy Converter'
  ..add-batch do
    'A sample SWF file':
      topic: -> new File do
        cwd: './projects'
        base: './projects/xx000'
        path: './projects/xx000/file.swf'
        contents: fixtures.swf

      'when converted to HTML':
        topic: -> convert \html it, @callback
        'should be like the manually converted HTML': at (file, contents) ->
          @equal (-> contents), fixtures.html
        'and should have the `swf.html` extension': at (file, contents) ->
          @equal (-> file.relative), \file.swf.html
        'and messages should be in the `file.data.swiffy` object': at (file, contents) ->
          @equal (-> file.data.swiffy.messages.length), 1
          @equal (-> file.data.swiffy.messages.0.type), 'INFO'
          @equal do
            -> file.data.swiffy.messages.0.description
            'Filters, blend modes and color-adjusted images may render slowly
           \ on mobile devices.'

    'Another SWF file':
      topic: -> new File do
        cwd: './projects'
        base: './projects/xx000'
        path: './projects/xx000/file.swf'
        contents: fixtures.swf

      'when converted to JSON':
        topic: -> convert \json it, @callback
        'should be like the manually converted JSON': at (file, contents) ->
          @equal (-> contents), fixtures.json
        'and should have the `swf.json` extension': at (file, contents) ->
          @equal (-> file.relative), \file.swf.json

  ..export module
