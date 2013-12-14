class GameRenderer

	renderer: null
	stage: null

	constructor: (@view) ->
		@renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight)
		@stage = new PIXI.Stage(0x000000)

		@view.appendChild @renderer.view

	render: =>
		@renderer.render @stage