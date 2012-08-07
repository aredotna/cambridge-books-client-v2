{Channel} = require('models/channel')
{ChannelView} = require('views/channel_view')

class exports.MainRouter extends Backbone.Router

  routes :
    "": "index"
    "*channels/show::block" : "block"
    "*channels":"channel"

  index: ->
    app.setRootChannel app.options.rootChannel
    app.layerManager.setFromPath()

  channel: (slug)->
    app.setRootChannel app.options.rootChannel
    app.layerManager.setFromPath(slug)

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
