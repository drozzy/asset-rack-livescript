rack = require \asset-rack
fs = require \fs
ls = require \LiveScript
path = require \path
uglify = require \uglify-js
require('events').EventEmitter

LiveScriptAsset = rack.Asset.extend({
  mimetype: 'text/javascript'
  create : !(options) ->
    @compress = options.compress or false
    @dirname = path.dirname (path.resolve options.filename)
    @toWatch = @dirname
    fs.readFile options.filename, (err, lsSource) ~>
      @contents = ls.compile(lsSource.toString('utf8'))
      @contents = uglify.minify(@contents, {fromString: true}).code if @compress
      @emit \created
})

module.exports = LiveScriptAsset
