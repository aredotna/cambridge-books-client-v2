{Channel} = require('models/channel')
{ChannelView} = require('views/channel_view')

class exports.MainRouter extends Backbone.Router

  routes :
    "": "index"
    ":slug": "channel"

  index: ->
  	app.addChannel app.options.rootChannel
	    
  channel: (slug)->
    app.addChannel slug