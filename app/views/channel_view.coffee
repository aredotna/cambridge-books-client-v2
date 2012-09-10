template = require './templates/channel'
{BlockView} = require './block_view'
  
class exports.ChannelView extends Backbone.View

  events:
    "click .block.Channel"  : "openChannel"
    "click .title"          : "makeTop"

  name: ->
    @model.options.slug

  initialize: ->
    @template = template
    @model.bind "add", @setViews, @
    @model.bind "loaded", @stopLoader, @
    @view = "list"
    @setViews()
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
    
  openChannel: (e)->
      id = parseInt($(e.currentTarget).attr('id'))
      block = @model.where(id:id)[0]
      app.openChannel(block.get('slug'))
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
      view.render()
      if num is 0 then $(view.el).addClass 'logo'
      @$el.find('.channelView').append view.el

    @delegateEvents()

  _setChannelClass: ->
    type = ''
    @model.each (block) ->
      if block.get('block_type') is "Channel"
        type = "menu"
    @channelClass = type

