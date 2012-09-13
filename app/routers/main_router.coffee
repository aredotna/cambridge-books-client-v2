{Channel} = require('models/channel')

{ChannelView} = require('views/channel_view')

class exports.MainRouter extends Backbone.Router

  routes :
    "": "index"
    "*channels/show::block" : "block"
    "*channels":"channel"

  initialize: ->
    @bind 'all', @_trackPageview()

  index: ->
    app.layerManager.setFromPath()

  channel: (slug)->
    app.layerManager.setFromPath(slug)

  block: (slug, block)->
    app.layerManager.setFromPath(slug)
    block = parseInt(block)
    app.addBlock block
    @navigateRelative "show:#{block}"

  navigateRelative: (slug, options)->
    path = Backbone.history.fragment
    path = path + '/' + slug
    @navigate path, options

  _trackPageview: ->
    url = Backbone.history.getFragment()
    _gaq.push(['_trackPageview', "/#{url}"])