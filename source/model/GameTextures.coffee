class GameTextures

	textures: {}

	constructor: (@images) ->
		arr = []
		for img in @images
			arr.push img.url
		@loader = new PIXI.AssetLoader(arr)

	load: (@onComplete) =>
		@loader.onComplete = @prepareTextures
		@loader.load()
		null

	prepareTextures: =>
		for img in @images
			@textures[img.id] = PIXI.Texture.fromImage img.url
		@onComplete()
		null

	getTexture: (id) =>
		return @textures[id]