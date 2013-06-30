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
               lsSource = fs.readFileSync(options.filename).toString('utf8')
               @contents = ls.compile(lsSource)
               @emit \created
})

module.exports = LiveScriptAsset
