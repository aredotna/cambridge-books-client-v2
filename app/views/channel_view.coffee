template = require './templates/channel'
{BlockView} = require './block_view'
  
class exports.ChannelView extends Backbone.View

  events:
    "click .block"  : "openBlock"
    "click .title"  : "makeTop"
    "click .viewLink" : "toggleView"

  initialize: ->
    @template = template
    @model.bind "add", @setViews, @
    @view = "grid"
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

  setViews: ->
    @blockViews = @model.map (block) ->
      new BlockView model:block
    @render()

  stopLoader: ->
    clearTimeout(@loaderTimer)
    @render()

  toggleView: ->
    @view = if @view is "grid" then "list" else "grid"
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
      channelClass: @channelClass()
      blocks: []

    _.each @blockViews, (view)=>
      view.render()
      @$el.find('.channelView').append view.el

    @delegateEvents()

  channelClass: ->
    type = @view
    @model.each (block) ->
      if block.get('block_type') is "Channel"
        type = "menu"
    type


