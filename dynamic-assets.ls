# TODO: THIS IS INCOMPLETE, BUGGY

#Directory asset for livescript asset...
DynamicAssets = la.DynamicAssets
assets = new rack.Rack([
    new DynamicAssets({
       urlPrefix: '/scripts'
       dirname : __dirname + "/client/app/ls"
       type : LiveScriptAsset
    })
])

rack = require \asset-rack
fs = require \fs
ls = require \LiveScript
require('events').EventEmitter
Asset = rack.Asset
LiveScriptAsset = rack.Asset.extend({
   create : !(options) ->
               lsSource = fs.readFileSync(options.filename).toString('utf8')
               @contents = ls.compile(lsSource)
               @emit \created
})


# For dynamic assets
async = require 'async'
pathutil = require('path')
mime = require('mime')

DynamicAssets = rack.StaticAssets.extend({
  getAssets: (dirname, prefix='', type=Asset, next) ->
        filenames = fs.readdirSync dirname
        async.forEachSeries filenames, (filename, next) ~>
            return next() if filename.slice(0, 1) is '.'
            path = pathutil.join dirname, filename
            stats = fs.statSync path
            if stats.isDirectory()
                newPrefix = "#{prefix}#{pathutil.basename(path)}/"
                @getAssets path, newPrefix, (newAssets) ~>
                    @assets.concat newAssets
                    next()
            else
                url = prefix + filename
                ext = pathutil.extname path
                mimetype = mime.types[ext.slice(1, ext.length)]
                contents = fs.readFileSync path
                if(mimetype?)
                    asset = new type( 
                        url: url
                        contents: contents
                        mimetype: mime.types[ext.slice(1, ext.length)]
                        hash: @hash
                        maxAge: @maxAge
                        )
                    asset.on 'complete', ~>
                        @assets.push asset
                        next()
                
                else
                    next()
        #, (error) ->
        #    next()
})

module.exports.LiveScriptAsset = LiveScriptAsset
module.exports.DynamicAssets = DynamicAssets
