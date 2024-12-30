local background = require("background")

love.states.addState("base", {
	exit = function()
		Tape.assert(false, "You shuld not pop base state")
	end,
	pausedDraw = function()
		MAIN_SCREEN:drawInsideRig()
		love.graphics.clear(BACKGROUND)
		background:draw()
		MAIN_SCREEN:stopDrawInsideRig()
	end,
})
