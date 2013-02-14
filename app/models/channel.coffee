{Block} = require 'models/block'

class exports.Channel extends Backbone.Collection

  model: Block

  defaults:
    depth: 0
    autoload: true

  url: ->
    "http://api.are.na/v2/channels/#{@options.slug}.json"

  comparator:(block) ->
    block.get 'position'
  
  initialize: (items, options)->
    @options = _.extend({}, @defaults, options)
    if @options.autoload
      @loadBlocks()

  bySelection: (selection=true) ->
    @_filtered (block) ->
        block.get('selected') is true

  loadBlocks: (depth=0) ->
    $.getJSON @url(), {}, (blocks)=>
      @attributes = _.clone blocks
      @add(blocks.contents)
      @trigger('loaded')

  _filtered: (criteria) ->
    new exports.Channel @select(criteria),
      autoload: false

  toJSON: ->
    blocks = {blocks:super()}
    _.extend({}, @attributes, blocks)

