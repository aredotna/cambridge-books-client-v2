{MainRouter} = require('routers/main_router')
{Channel} = require('models/channel')
{Block} = require('models/block')
{LayerManager} = require('views/layer_manager')
{LayerView} = require('views/layer_view')
{ChannelView} = require('views/channel_view')
{BlockView} = require('views/block_view')
{OverlayView} = require('views/overlay_view')
{AppView} = require('views/app_view')

class exports.Application

  defaults: {}

  initialize: (options)->
    @options = {}
    _.extend(@options, options)
    @layerManager = new LayerManager el: $('#layers')
    @overlay = new OverlayView el: $('#overlay')
    @router = new MainRouter()
    @appView = new AppView el: $('body')
    Backbone.history.start()

  openChannel: (slug)->
    @addChannel(slug)
    @resetUrl()

  addChannel: (slug)->
    channel = new Channel null,
      slug: slug
    view = new ChannelView(model:channel)
    @addLayer(view)
    channel

  openBlock: (block)->
    block = new Block(block)
    view = new BlockView(model:block)
    @overlay.open(view)
    @resetUrl()
    @router.navigateRelative('show:' + block.id)

  addLayer: (content)->
    @layerManager.addLayer(content)

  resetUrl: ->
    @router.navigate @layerManager.currentPath()