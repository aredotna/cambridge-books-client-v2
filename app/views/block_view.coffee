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
    @delegateEvents()

  name: ->
    @model.get 'title'

  title: ->
    @model.get 'title'