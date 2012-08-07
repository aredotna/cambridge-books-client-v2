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
    @blockViews = @model.bySelection().map (block) ->
      new BlockView model:block
    @_setChannelClass()
    @render()

  stopLoader: ->
    clearTimeout(@loaderTimer)
    @render()

  toggleView: ->
    @view = if @view is "grid" then "list" else "grid"
    @_setChannelClass()
    @render()

  openBlock: (e)->
    if $(e.currentTarget).is(".Image") or $(e.currentTarget).is(".Channel")
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
      channelClass: @channelClass
      blockLength: @blockViews.length

    _.each @blockViews, (view, num)=>
      if @channelClass == "menu" || num !=0
        view.render()
        @$el.find('.channelView').append view.$el.find('>li')

    @delegateEvents()

  _setChannelClass: ->
    type = @view
    @model.each (block) ->
      if block.get('block_type') is "Channel"
        type = "menu"
    @channelClass = type

