
class exports.AppView extends Backbone.View

  events:
    "click #infoLink" : "reset"
    "click #topArrow" : "returnToTop"

  initialize: ->

    $(window).scroll ->
      if $('body').scrollTop() > $(window).height()
        $('#topArrow').fadeIn().addClass('shown')
      else if $('#topArrow').hasClass('shown')
        $('#topArrow').fadeOut().removeClass('shown')


  returnToTop: ->
    console.log 'returning'
    $('body').animate
      scrollTop: 0
    false

  reset: ->
    app.reset()