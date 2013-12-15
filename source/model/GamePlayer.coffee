class GamePlayer

	lastMove: null

	falling: false

	scale: 1

	constructor: (@grid, @x, @y) ->
		@isMoving = false

	move: (xmov, ymov) =>
		@lastMove = {x:xmov, y:ymov}
		@isMoving = true
		newx = @x + xmov
		newy = @y + ymov
		if newx < 0 then newx = 0
		else if newx > @grid.gridWidth-1 then newx = @grid.gridWidth-1
		if newy < 0 then newy = 0
		else if newy > @grid.gridHeight-1 then newy = @grid.gridHeight-1

		if newx != @x or newy != @y
			@isMoving = true
			@doMove newx, newy, false
		else
			@isMoving = false
		null

	doMove: (x, y, isJump) =>
		time = if isJump then 1 else 0.15
		if isJump
			TweenMax.to @, time*0.5, {scale:1.5, ease:Power2.easeOut, onComplete:=>
				TweenMax.to @, time*0.5, {scale:1, ease:Power2.easeIn}
			}
		TweenMax.to @, time, {x:x, y:y, ease:Power2.easeOut, onComplete:=>
			@grid.checkLanding x, y
			@isMoving = false
		}
		null

	toStartPosition: (x, y) =>
		@x = x
		@y = y
		null

	fall: =>
		@falling = true
		null

	jump: =>
		@isMoving = true
		newx = @x + (@lastMove.x*2)
		newy = @y + (@lastMove.y*2)
		@doMove newx, newy, true
		null