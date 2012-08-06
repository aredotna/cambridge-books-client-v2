template = require './templates/channel'
{BlockView} = require './block_view'
  
class exports.ChannelView extends Backbone.View

  events:
    "click .block"  : "openBlock"
    "click .title"  : "makeTop"

  initialize: ->
    @template = template
    @model.bind "add", @setViews, @
    @setViews()
    @model.bind "loaded", @stopLoader, @
    @animateLoader(0)

  animateLoader: (step)->
    if (step > 3) then step = 0
    html = 'Loading'
    (html += '.') for i in [0..step]
    @$el.find('.title').html(html)
    @loaderTimer = setTimeout =>
      @animateLoader(step + 1)
    , 300

  stopLoader: ->
    clearTimeout(@loaderTimer)
    @render()


  openBlock: (e)->
    id = parseInt(e.currentTarget.id)
    block = @model.where(id:id)[0]

    if block.get('block_type') is "Channel"
      app.openChannel(block.get('slug'))
    else 
      app.openBlock(block)
    false

  makeTop: ->
    @layer.makeTop()

  render: ->
    data = @model.toJSON()
    @$el.html @template
      title: data.title
      type: @type()
      blocks: []

    _.each @blockViews, (view)=>
      view.render()
      @$el.find('.channelView').append view.el

    @delegateEvents()

    @model.each (block) ->
      if block.get('block_type') is "Channel"
        type = "menu"
    type


