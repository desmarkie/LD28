class GameTile

	pickup: false
	falling: false

	constructor: (@x, @y) ->
		@state ='normal'
