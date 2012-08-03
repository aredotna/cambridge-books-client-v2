template = require './templates/block'


class exports.BlockView extends Backbone.View

  events: 
    "click .connectionLink" : "openConnection"

  initialize: ->
    @template = template
    @model.bind "update", @render, @

  openConnection: (e)->
    slug = $(e.target).data('slug')
    app.overlay.close()
    app.openChannel(slug) 

  render: ->
    @$el.html @template 
      block: @model.toJSON()
      connectedChannels: @model.connectedChannels()
    @delegateEvents()