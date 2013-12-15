class GameGrid

	gridWidth: 10
	gridHeight: 10

	player: null

	tiles: null

	pickups: null

	exits: false

	complete: false

	currentLevel: null

	exitPos: {x:0, y:0}

	constructor: (@completeCallback) ->
		@player = new GamePlayer(@, 0, 0)

	clearCurrentLevel: =>
		@tiles = null
		@pickups = null
		@exits = false
		@complete = false
		# @player.x = @player.y = 0
		null

	createGrid: (level) =>
		if @currentLevel != null then @clearCurrentLevel()
		@currentLevel = level
		@tiles = []
		@pickups = []

		for i in [0..@gridWidth-1] by 1
			@tiles[i] = []
			for j in [0..@gridHeight-1] by 1
				@tiles[i][j] = new GameTile(i, j)
				if @currentLevel[i+'_'+j]
					@tiles[i][j].state = @currentLevel[i+'_'+j]
					if @tiles[i][j].state == 'exit_open' or @tiles[i][j].state == 'exit_closed'
						@tiles[i][j].state = 'exit_closed'
						@exitPos.x = i
						@exitPos.y = j
					if @currentLevel.pickups[i+'_'+j]
						@tiles[i][j].pickup = true
						@pickups.push i+'_'+j
		@numPickups = @pickups.length
		@player.toStartPosition @currentLevel.startPos.x, @currentLevel.startPos.y
		null

	checkLanding: (x, y) =>
		if window.app.editMode then return
		@checkFloor x, y
		@checkPickup x, y
		@checkJump x, y
		if @exits then @checkExit x, y
		null


	checkFloor: (x, y) =>
		if @tiles[x][y].state == 'normal'
			@player.fall()
		null

	checkJump: (x, y) =>
		if @tiles[x][y].state == 'jump'
			@player.jump()
		null

	checkPickup: (x, y) =>
		if @complete then return
		i = @pickups.indexOf x+'_'+y
		if i != -1
			@tiles[x][y].pickup = false
			@numPickups--
			@pickups.splice i, 1

		if @numPickups == 0
			@openExits()
		null

	checkExit: (x, y) =>
		if @complete then return
		if x == @exitPos.x and y == @exitPos.y
			@complete = true
			@completeCallback()
		null

	openExits: =>
		@exits = true
		@tiles[@exitPos.x][@exitPos.y].state = 'exit_open'
		null

	update: =>
		if @complete then return
		if !@player.isMoving
			moveDir = {x:0, y:0}
			if window.app.leftPressed
				moveDir.x -= 1
				window.app.leftPressed = false
			if window.app.rightPressed
				moveDir.x += 1
				window.app.rightPressed = false
			if window.app.upPressed
				moveDir.y -= 1
				window.app.upPressed = false
			if window.app.downPressed
				moveDir.y += 1
				window.app.downPressed = false
			
			if moveDir.x != 0 or moveDir.y != 0
				newx = @player.x + moveDir.x
				newy = @player.y + moveDir.y
				if !@currentLevel[newx+'_'+newy] and !window.app.editMode
					moveDir.x = moveDir.y = 0
				else
					@player.move moveDir.x, moveDir.y
		null

	getLevelData: =>
		obj = {}
		pickups = {}
		startPos = {x:@player.x, y:@player.y}
		for i in [0..@gridWidth-1] by 1
			for j in [0..@gridHeight-1] by 1
				if @tiles[i][j].state != 'normal'
					obj[i+'_'+j] = @tiles[i][j].state
				if @tiles[i][j].pickup
					pickups[i+'_'+j] = true

		obj.pickups = pickups
		obj.startPos = startPos

		return obj

