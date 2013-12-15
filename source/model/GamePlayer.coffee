class GamePlayer

	constructor: (@grid, @x, @y) ->
		@isMoving = false

	move: (xmov, ymov) =>
		@isMoving = true
		newx = @x + xmov
		newy = @y + ymov
		if newx < 0 then newx = 0
		else if newx > @grid.gridWidth-1 then newx = @grid.gridWidth-1
		if newy < 0 then newy = 0
		else if newy > @grid.gridHeight-1 then newy = @grid.gridHeight-1
		if newx != @x or newy != @y
			TweenMax.to @, 0.3, {x:newx, y:newy, ease:Power4.easeOut, onComplete:=>
				@isMoving = false
				if @grid.exits
					@grid.checkExit @x, @y
				else
					@grid.checkPickup @x, @y
			}
		else
			@isMoving = false
		null