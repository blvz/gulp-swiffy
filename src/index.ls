require! {
  request
  through2: through
  \gulp-util
}

SWIFFY_URL = \https://www.google.com/doubleclick/studio/swiffy/upload

function convert file, fmt, cb
  r = do
    err, res, body <~ request.post SWIFFY_URL
    return cb err if err
    return cb res.status-message if res.status-code isnt 200

    data = JSON.parse body.substr 4
    data = data[*-3]
    url = data[*-1] + data[*-2]

    err, res, body <~ request url
    return cb err if err

    if fmt is \json
      body = (/swiffyobject\s*=\s*(.*)(?=;\s*<\/script>)/ is body).1 + \\n

    file.contents = new Buffer body
    file.path = gulp-util.replace-extension file.path, ".swf.#fmt"
    cb null file

  r.form!append \swfFile file.contents, switch
    | file.is-buffer! => filename: file.path
    | file.is-stream! => null

module.exports = (fmt) ->
  fmt? .= to-lower-case!
  fmt = \html unless fmt is \json
  through.obj (file, enc, cb) ->
    return cb null file if file.is-null!
    convert file, fmt, cb
