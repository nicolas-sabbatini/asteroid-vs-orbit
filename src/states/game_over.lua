local gui = require("gui.game_over")
local star = require("star")

love.states.addState("game_over", {
	enter = function(score)
		gui:updateScore(score)
		gui:append()
	end,
	update = function(dt)
		star:update(dt)
	end,
	draw = function()
		MAIN_SCREEN:drawInsideRig()
		star:draw()
		MAIN_SCREEN:stopDrawInsideRig()
		gui:draw()
	end,
	exit = function()
		gui:remove()
	end,
})
