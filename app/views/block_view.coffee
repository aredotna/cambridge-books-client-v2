template = require './templates/block'


class exports.BlockView extends Backbone.View

  attributes:
    class: "blockCont"
      
  events: 
    "click .connectionLink" : "openConnection"

  initialize: ->
    @template = template
    @model.bind "change", @render, @

  openConnection: (e)->
    slug = $(e.target).data('slug')
    app.openChannel(slug) 

  render: ->
    @$el.html @template 
      block: @model.toJSON()
      connectedChannels: @model.connectedChannels()
    if @model.get('in_menu') && @model.get('class') is "Channel"
      @$el.addClass('menu')

    @delegateEvents()
    @loadPreview()

  loadPreview: ->
    preview = @$el.find('.channel-preview-image')
    if preview.length
      $.get "http://api.are.na/v2/channels/#{preview.data('slug')}/thumb.json", (data, ajax)->
        d = data.contents
        i = _.find d, (block)-> block.class is "Image"
        if i
          src = i.image.display.url
          preview.append('<img src="' + src + '">')
          preview.removeClass('loading')

  name: ->
    @model.get 'title'

  title: ->
    @model.get 'title'