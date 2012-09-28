{BlockView} = require './block_view'
template = require 'views/templates/base'

class exports.BaseView extends Backbone.View

  template: template

  initialize: ->
    @model.bind "loaded", @setViews, @
    $(window).resize => @center()
    @setViews()

  render: ->
    @$el.html @template()

    _.each @blockViews, (view)=>
      view.render()
      view.$el.appendTo(@$('#baseInner'))

    @$('#baseInner').masonry(itemSelector:'.blockCont', gutter: 36)

    @$el.imagesLoaded => @masonry()
    @masonry()
    @center()

  masonry: ->
    @$('#baseInner').masonry('reload')

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
    if numColumns isnt 0
      $('#baseInner').css
        width: Math.floor(numColumns * cW)
    else
      width: wW
