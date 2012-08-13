{BlockView} = require './block_view'

class exports.BaseView extends Backbone.View

  initialize: ->
    @model.bind "loaded", @setViews, @
    @setViews()

  render: ->
    @$el.html('')
    _.each @blockViews, (view)=>
      view.render()
      view.$el.appendTo(@$el)

  setViews: ->
    @blockViews = @model.bySelection().map (block) ->
      new BlockView model:block
    @render()