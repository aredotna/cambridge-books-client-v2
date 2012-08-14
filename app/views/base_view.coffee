{BlockView} = require './block_view'

class exports.BaseView extends Backbone.View

  initialize: ->
    @model.bind "loaded", @setViews, @
    $('#base').masonry(itemSelector:'.blockCont', gutter: 20)
    $(window).resize => @render()
    @setViews()

  render: ->
    @$el.html('')
    _.each @blockViews, (view)=>
      view.render()
      view.$el.appendTo(@$el)
    @$el.imagesLoaded => @masonry()
    @masonry()

  masonry: ->
    $('#base').masonry('reload')

  setViews: ->
    @blockViews = @model.bySelection().map (block) ->
      new BlockView model:block
    @render()