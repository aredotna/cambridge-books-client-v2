{Channel} = require('models/channel')
{ChannelView} = require('views/channel_view')

class exports.MainRouter extends Backbone.Router

  routes :
    "": "index"
    ":slug": "channel"

  index: ->
  	channel = new Channel null, 
      slug: app.options.rootChannel,
      depth: 3
  	app.setView new ChannelView(model: channel)
	    
  channel: (slug)->
    channel = new Channel null, 
      slug:slug
    app.setView new ChannelView(model:channel)