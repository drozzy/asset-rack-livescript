rack = require \asset-rack
fs = require \fs
ls = require \LiveScript
path = require \path
require('events').EventEmitter

LiveScriptAsset = rack.Asset.extend({
  mimetype: 'text/javascript'
  create : !(options) ->
    @dirname = path.dirname (path.resolve options.filename)
    @toWatch = @dirname
    fs.readFile options.filename, (err, lsSource) ~>
      @contents = ls.compile(lsSource.toString('utf8'))
      @emit \created
})

module.exports = LiveScriptAsset
