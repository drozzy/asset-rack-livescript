rack = require \asset-rack
fs = require \fs
ls = require \LiveScript
require('events').EventEmitter

LiveScriptAsset = rack.Asset.extend({
   create : !(options) ->
               lsSource = fs.readFileSync(options.filename).toString('utf8')
               @contents = ls.compile(lsSource)
               @emit \created
})

module.exports = LiveScriptAsset
