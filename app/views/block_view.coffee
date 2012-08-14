template = require './templates/block'


class exports.BlockView extends Backbone.View

  attributes:
    class: "blockCont"
      
  events: 
    "click .connectionLink" : "openConnection"

  initialize: ->
    @template = template
    @model.bind "update", @render, @

  openConnection: (e)->
    console.log 'opening'
    slug = $(e.target).data('slug')
    app.openChannel(slug) 

  render: ->
    @$el.html @template 
      block: @model.toJSON()
      connectedChannels: @model.connectedChannels()
    @delegateEvents()