{Block} = require 'models/block'

class exports.Channel extends Backbone.Collection

	model: Block

	defaults:
		depth: 0
		autoload: true

	url: ->
		"http://arena-cedar.herokuapp.com/api/v1/channels/#{@options.slug}.json?callback=?"

	initialize: (items, options)->
		@options = _.extend({}, @defaults, options)
		if @options.autoload
			@loadBlocks(@options.depth)

	loadBlocks: (depth=0) ->
		@fetch
			success: (channel, blocks)=>
				@reset()
				@add(blocks.blocks)
				@add(blocks.channels)
				if depth
					@each (block)->
						if block.get('block_type') is "Channel" and block.get('published')
							@channel = new Channel null, 
								slug:block.get('slug')
								depth: channel.options.depth - 1
