{Channel} = require('models/channel')
{ChannelView} = require('views/channel_view')

class exports.MainRouter extends Backbone.Router

  routes :
    "": "index"
    "*channels/show::block" : "block"
    "*channels":"channel"

  index: ->
    app.addChannel app.options.rootChannel
    
  channel: (slug)->
    channels = slug.split('/')
    app.addChannel app.options.rootChannel

    channelModels = channels.map (channel)->
      app.addChannel channel
    channelModels

  block: (slug, block)->
    channels = @channel(slug)
    block = parseInt(block)
    last = channels.pop()

    last.bind 'loaded', _.bind((data)->
      channel = data[0]
      block = data[1]
      app.openBlock channel.where(id:block)[0]
    , this, [last, block])


  navigateRelative: (slug)->
    path = Backbone.history.fragment
    path = path + '/' + slug
    @navigate path
