{BlockView} = require './block_view'

class exports.BaseView extends Backbone.View

  initialize: ->
    @model.bind "loaded", @setViews, @
    @$el.masonry(itemSelector:'.blockCont', gutter: 36)
    $(window).resize => @render()
    @setViews()

  render: ->
    @$el.html('')
    _.each @blockViews, (view)=>
      view.render()
      view.$el.appendTo(@$el)
    @$el.imagesLoaded => @masonry()
    @masonry()
    @center()

  masonry: ->
    $('#base').masonry('reload')

  setViews: ->
    @blockViews = @model.bySelection().map (block) ->
      new BlockView model:block
    @render()

  center: ->
    wW = $(window).width()
    cW = 433
    numColumns = Math.floor(wW/cW)
    if numColumns > $('#base').find('.block').length
      numColumns = $('#base').find('.block').length
    $('#base').css
      width: Math.floor(numColumns * cW)
