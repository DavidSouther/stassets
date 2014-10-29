fs = require 'graceful-fs'
AssetBuilder = require('./Asset')

class IndexWatcher extends AssetBuilder
    constructor: (@config)->
        super()

    pattern: -> super [ "index.jade" ]

    getPaths: -> ['/', '/index.html']
    matches: (path)->
        if @config.deeplink
            # /api is allowed, non deep links are allowed.
            if not path.match /^\/(?:api|[^/]+$)/
                return true
        super path
    type: -> "text/html; charset=utf-8"

    render: (_, filename)->
        require('jade').compile(_, {filename})(@config.configs)

module.exports = IndexWatcher
