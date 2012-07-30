{MainRouter} = require('routers/main_router')
{Channel} = require('models/channel')
{Block} = require('models/block')
{LayerManager} = require('views/layer_manager')
{LayerView} = require('views/layer_view')
{ChannelView} = require('views/channel_view')
{BlockView} = require('views/block_view')

class exports.Application

  defaults: {}

  initialize: (options)->
    @options = {}
    _.extend(@options, options)
    @layerManager = new LayerManager
    	el: $('#layers')

    @router = new MainRouter()
    Backbone.history.start()

  openChannel: (slug)->
    @router.navigateRelative(slug)

  addChannel: (slug)->
    channel = new Channel null,
      slug: slug
    view = new ChannelView(model:channel)
    @addLayer(view)

  addBlock: (block)->
    block = new Block(block)
    view = new BlockView(model:block)
    @addLayer(view)

  addLayer: (content)->
    @layerManager.addLayer(content)

  resetUrl: ->
    @router.navigate @layerManager.currentPath()