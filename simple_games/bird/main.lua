function moon.load()
	playingAreaWidth = 300
	playingAreaHeight = 388

	birdX = 62
	birdWidth = 30
	birdHeight = 25

	pipeSpaceHeight = 100
	pipeWidth = 54

	math.randomseed(os.time())
	function newPipeSpaceY()
		local pipeSpaceYMin = 54
		local pipeSpaceY = math.random(
			pipeSpaceYMin,
			playingAreaHeight - pipeSpaceHeight - pipeSpaceYMin
		)
		return pipeSpaceY
	end

	function reset()
		birdY = 200
		birdYSpeed = 0

		pipe1X = playingAreaWidth
		pipe1SpaceY = newPipeSpaceY()

		pipe2X = playingAreaWidth + ((playingAreaWidth + pipeWidth) / 2)
		pipe2SpaceY = newPipeSpaceY()

		score = 0

		upcomingPipe = 1
	end

	reset()
end

function moon.update(dt)
	birdYSpeed = birdYSpeed + (516 * dt)
	birdY = birdY + (birdYSpeed * dt)

	local function movePipe(pipeX, pipeSpaceY)
		pipeX = pipeX - (60 * dt)

		if (pipeX + pipeWidth) < 0 then
			pipeX = playingAreaWidth
			pipeSpaceY = newPipeSpaceY()
		end

		return pipeX, pipeSpaceY
	end

	pipe1X, pipe1SpaceY = movePipe(pipe1X, pipe1SpaceY)
	pipe2X, pipe2SpaceY = movePipe(pipe2X, pipe2SpaceY)

	function isBirdCollidingWithPipe(pipeX, pipeSpaceY)
		return
		-- Left edge of bird is to the left of the right edge of pipe
		birdX < (pipeX + pipeWidth)
		and
		 -- Right edge of bird is to the right of the left edge of pipe
		(birdX + birdWidth) > pipeX
		and (
			-- Top edge of bird is above the bottom edge of first pipe segment
			birdY < pipeSpaceY
			or
			-- Bottom edge of bird is below the top edge of second pipe segment
			(birdY + birdHeight) > (pipeSpaceY + pipeSpaceHeight)
		)
	end

	if isBirdCollidingWithPipe(pipe1X, pipe1SpaceY)
	or isBirdCollidingWithPipe(pipe2X, pipe2SpaceY)
	or birdY > playingAreaHeight then
		reset()
	end

	local function updateScoreAndClosestPipe(thisPipe, pipeX, otherPipe)
		if upcomingPipe == thisPipe
		and (birdX > (pipeX + pipeWidth)) then
			score = score + 1
			upcomingPipe = otherPipe
		end
	end

	updateScoreAndClosestPipe(1, pipe1X, 2)
	updateScoreAndClosestPipe(2, pipe2X, 1)
end

function moon.draw()
	moon.graphics.set_color(35, 92, 118)
	moon.graphics.rectangle('fill', 0, 0, playingAreaWidth, playingAreaHeight)

	moon.graphics.set_color(224, 214, 68)
	moon.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight)

	local function drawPipe(pipeX, pipeSpaceY)
		moon.graphics.set_color(94, 201, 72)
		moon.graphics.rectangle(
			'fill',
			pipeX,
			0,
			pipeWidth,
			pipeSpaceY
		)
		moon.graphics.rectangle(
			'fill',
			pipeX,
			pipeSpaceY + pipeSpaceHeight,
			pipeWidth,
			playingAreaHeight - pipeSpaceY - pipeSpaceHeight
		)
	end

	drawPipe(pipe1X, pipe1SpaceY)
	drawPipe(pipe2X, pipe2SpaceY)

	moon.graphics.set_color(255, 255, 255)
	moon.graphics.print(score, 15, 15)
end

function moon.keypressed(key)
	if birdY > 0 then
		birdYSpeed = -165
	end
end

