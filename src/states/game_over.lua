local gui = require("gui.game_over")
local star = require("star")

love.states.addState("game_over", {
	enter = function(score)
		Tape.log("debug", "Enter game over state")
		gui:updateScore(score)
		gui:append()
	end,
	update = function(dt)
		star:update(dt)
		gui:update()
	end,
	draw = function()
		MAIN_SCREEN:drawInsideRig()
		star:draw()
		MAIN_SCREEN:stopDrawInsideRig()
		gui:draw()
	end,
	exit = function()
		Tape.log("debug", "Exit game over state")
		gui:remove()
	end,
})
