{Block} = require 'models/block'

class exports.Channel extends Backbone.Collection

  model: Block

  defaults:
    depth: 0
    autoload: true

  url: ->
    "http://api.are.na/v1/channels/#{@options.slug}.json?callback=?"

  comparator:(block) ->
    block.get 'position'
  
  initialize: (items, options)->
    @options = _.extend({}, @defaults, options)
    if @options.autoload
      @loadBlocks(@options.depth)

  bySelection: (selection=true) ->
    @_filtered (block) ->
        block.get('arrangement') is selection

  loadBlocks: (depth=0) ->
    $.getJSON @url(),
      (blocks)=>
        @attributes = _.clone blocks
        newBlocks =
        @add(blocks.blocks, silent:true)
        @add(blocks.channels, silent: true)

        @trigger('add')
        @trigger('loaded')
        
        if depth
          @each (block)->
            if block.get('block_type') is "Channel" and block.get('published')
              @channel = new Channel null, 
                slug:block.get('slug')
                  depth: channel.options.depth - 1


  _filtered: (criteria) ->
    new exports.Channel @select(criteria),
      autoload: false

  toJSON: ->
    blocks = {blocks:super()}
    _.extend({}, @attributes, blocks)

