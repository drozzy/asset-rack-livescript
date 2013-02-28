asset-rack-livescript
=====================

Livescript support for asset-rack

Usage
-----
Just use the `LiveScriptAsset` like a regular asset-rack asset:

	LiveScriptAsset = require \asset-rack-livescript

	assets = new rack.Rack([
	  new LiveScriptAsset(
	     url: '/js/controllers.js',
	     filename: __dirname + '/client/app/ls/controllers.ls'
	  ),
	  new LiveScriptAsset(
	     url: '/js/app.js',
	     filename: __dirname + '/client/app/ls/app.ls'
	  )
	])

	app.use(assets)
