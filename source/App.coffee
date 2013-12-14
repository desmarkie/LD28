# import renderer.*
class App

	renderer: null

	constructor: ->
		@renderer = new GameRenderer document.getElementById('game-holder')

		requestAnimationFrame @update

	update: =>
		@renderer.render()
		null