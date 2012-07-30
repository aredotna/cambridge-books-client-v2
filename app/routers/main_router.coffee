{Channel} = require('models/channel')
{ChannelView} = require('views/channel_view')

class exports.MainRouter extends Backbone.Router

  routes :
    "": "index"
    "*channels": "channel"

  index: ->
    app.addChannel app.options.rootChannel
    
  channel: (slug)->
    channels = slug.split('/')
    app.addChannel app.options.rootChannel
    channels.forEach (channel)->
      app.addChannel channel

  navigateRelative: (slug)->
    path = Backbone.history.fragment
    path = path + '/' + slug
    @navigate path
    app.addChannel(slug)
