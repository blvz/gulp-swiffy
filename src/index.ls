require! {
  debug
  'swiffy-convert'
  'through2-concurrent': through
}

debug = debug 'swiffy'

module.exports = (fmt, opts = max-concurrency: 10) ->
  fmt? .= to-lower-case!
  fmt = \html unless fmt is \json

  through.obj do
    {opts.max-concurrency}
    (file, enc, cb) ->
      debug "Converting #{file.relative}:"
      return cb null file if file.is-null!

      err, res <~ swiffy-convert file.contents
      return cb err if err

      if res.messages?
        debug "Messages for #{file.relative}:\n" +
        (res.messages.map -> "[ #{it.type} ] #{it.description}") * '\n'

      (file.data ?= {}) <<< swiffy: {res.messages}

      file.contents = new Buffer res.output[fmt]
      file.path .= replace /\.swf$/i ".swf.#fmt"
      cb null file
