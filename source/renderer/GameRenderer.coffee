class GameRenderer

	renderer: null
	stage: null

	tiles: {}
	sprites: []
	deadSprites: []

	pickups: {}
	deadPickups: []

	tileSize: 64

	tileHolder: null
	playerSprite: null

	editPanel: null

	editState: 'normal'

	constructor: (@view) ->
		@texManager = window.app.textures
		@renderer = PIXI.autoDetectRenderer(640, 640)
		@stage = new PIXI.Stage(0x000000, true)

		@bg = new PIXI.DisplayObjectContainer()
		tile = new PIXI.Sprite @texManager.getTexture('bg')
		tile.scale.x = tile.scale.y = 2
		@bg.addChild tile
		tile = new PIXI.Sprite @texManager.getTexture('bg')
		tile.scale.x = tile.scale.y = 2
		tile.position.x = 640
		@bg.addChild tile
		tile = new PIXI.Sprite @texManager.getTexture('bg')
		tile.scale.x = tile.scale.y = 2
		tile.position.y = 640
		@bg.addChild tile
		tile = new PIXI.Sprite @texManager.getTexture('bg')
		tile.scale.x = tile.scale.y = 2
		tile.position.x = 640
		tile.position.y = 640
		@bg.addChild tile

		@stage.addChild @bg

		@levelHolder = new PIXI.DisplayObjectContainer()
		@stage.addChild @levelHolder
		@levelHolder.position.x = 320
		@levelHolder.position.y = 320

		@tileHolder = new PIXI.DisplayObjectContainer()
		@tileHolder.position.x = -320
		@tileHolder.position.y = -320
		@levelHolder.addChild @tileHolder

		@pickupHolder = new PIXI.DisplayObjectContainer()
		@pickupHolder.position.x = -320
		@pickupHolder.position.y = -320
		@levelHolder.addChild @pickupHolder

		@playerSprite = new PIXI.Sprite @texManager.getTexture('player')
		@playerSprite.pivot.x = @playerSprite.pivot.y = 32
		@levelHolder.addChild @playerSprite

		@levelHolder.scale.x = @levelHolder.scale.y = 0.25
		@levelHolder.alpha = 0
		@levelHolder.rotation = Math.PI

		@editPanel = new EditPanel()

		@view.appendChild @renderer.view

	render: (@grid) =>
		@drawTiles @grid.tiles, @grid.gridWidth, @grid.gridHeight
		if @grid.player.x == @grid.currentLevel.startPos.x and @grid.player.y == @grid.currentLevel.startPos.y
			@playerSprite.scale.x = @playerSprite.scale.y = @playerSprite.alpha = 1
			@playerSprite.rotation = 0
		@playerSprite.position.x = ((@grid.player.x * @tileSize) - 320) + 32
		@playerSprite.position.y = ((@grid.player.y * @tileSize) - 320) + 32
		if @grid.player.falling
			@grid.player.falling = false
			TweenMax.to @playerSprite.scale, 1, {x:0.2, y:0.2}
			TweenMax.to @playerSprite, 1, {rotation:Math.PI, alpha:0, onComplete:=>
				window.app.reset()
			}
		else
			@playerSprite.scale.x = @playerSprite.scale.y = @grid.player.scale

		@bg.position.x++
		@bg.position.y++
		if @bg.position.x > 0
			@bg.position.x -= 640
		if @bg.position.y > 0
			@bg.position.y -= 640

		@renderer.render @stage
		null

	showLevel: =>
		TweenMax.to @levelHolder, 1, {alpha: 1, rotation: 0, ease:Power4.easeOut}
		TweenMax.to @levelHolder.scale, 1, {x:1, y:1, ease:Power4.easeOut}
		null

	hideLevel: (onComplete) =>
		TweenMax.to @levelHolder.scale, 1, {x:2, y:2, ease:Power4.easeOut}
		TweenMax.to @levelHolder, 1, {alpha: 0, rotation: -Math.PI, ease:Power4.easeOut, onComplete:=>
			@levelHolder.scale.x = @levelHolder.scale.y = 0.25
			@levelHolder.rotation = Math.PI
			onComplete()
		}
		null

	showEditPanel: =>
		@stage.addChild @editPanel.view
		@editPanel.enable()
		null

	hideEditPanel: =>
		@stage.removeChild @editPanel.view
		@editPanel.disable()
		null


	drawTiles: (tiles, xCount, yCount) =>
		for i in [0..xCount-1] by 1
			for j in [0..yCount-1] by 1
				tileRef = tiles[i][j]
				@setSprite tileRef
				if tileRef.pickup
					@setPickup i, j
				else if @pickups[i+'_'+j]
					@clearPickup i, j
		null

	clearPickup: (x, y) =>
		@deadPickups.push @pickups[x+'_'+y]
		@pickupHolder.removeChild @pickups[x+'_'+y]
		delete @pickups[x+'_'+y]
		null

	setPickup: (x, y) =>
		if !@pickups[x+'_'+y]
			arr = []
			for i in [1..8] by 1
				for j in [0..8] by 1
					digit = i
					if digit == 6 then digit = 4
					else if digit == 7 then digit = 3
					else if digit == 8 then digit = 2
					arr.push @texManager.getTexture('pickup_0'+digit)
			if @deadPickups.length > 0
				sp = @deadPickups[0]
				@deadPickups.splice 0, 1
			else
				sp = new PIXI.MovieClip arr
			sp.position.x = x * @tileSize
			sp.position.y = y * @tileSize
			@pickups[x+'_'+y] = sp
			@pickupHolder.addChild sp
			sp.gotoAndPlay Math.ceil(Math.random() * arr.length)
		null

	setSprite: (tile) =>
		tileId = tile.x+'_'+tile.y
		# console.log 'tile exists ? '+ if @tiles[tileId] then 'y' else 'n'
		if !@tiles[tileId]
			@tiles[tileId] = new PIXI.Sprite @texManager.getTexture(tile.state)
			@tiles[tileId].position.x = tile.x * @tileSize
			@tiles[tileId].position.y = tile.y * @tileSize
			@tileHolder.addChild @tiles[tileId]
			@tiles[tileId].interactive = true
			@tiles[tileId].mousedown = @tileClick
		else if @texManager.getTexture(tile.state) != @tiles[tileId].texture
			@tiles[tileId].setTexture @texManager.getTexture(tile.state)

		return @tiles[tileId]

	tileClick: (e) =>
		if !window.app.editMode then return
		xPos = Math.floor(e.target.position.x / 64)
		yPos = Math.floor(e.target.position.y / 64)
		if @editState != 'pickup'
			curState = @grid.tiles[xPos][yPos].state
			@grid.tiles[xPos][yPos].state = @editState
		else
			@grid.tiles[xPos][yPos].pickup = !@grid.tiles[xPos][yPos].pickup
		null
