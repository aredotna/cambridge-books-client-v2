template = require './templates/channel'
{BlockView} = require './block_view'
  
class exports.ChannelView extends Backbone.View

  events:
    "click .block.Channel"  : "openChannel"
    "click .title"          : "makeTop"
    "click .permalink"      : "openBlock"

  name: ->
    @model.options.slug

  initialize: ->
    @template = template
    @model.bind "add", @setViews, @
    @model.bind "loaded", @stopLoader, @
    @view = "list"
    @setViews()

  setViews: ->
    @blockViews = @model.bySelection().map (block) ->
      new BlockView model:block
    @_setChannelClass()
    @render()

  openChannel: (e)->
    id = parseInt($(e.currentTarget).attr('id'))
    block = @model.where(id:id)[0]
    app.openChannel(block.get('slug'))
    false

  openBlock: (e)->
    id = parseInt $(e.currentTarget).closest('li').attr('id')
    app.router.navigateRelative 'show/' + id, trigger: true
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
      if block.get('class') is "Channel"
        type = "menu"
    @channelClass = type

  title: ->
    @model.attributes?.title

