local player = require("player")
local star = require("star")
local gui = require("gui.play")

love.states.addState("play", {
	enter = function()
		Tape.log("debug", "Enter play state")
		player:restart()
		gui:append()
	end,
	update = function(dt)
		star:update(dt)
		player:updateMovement(dt)
		player:updateGraphics(dt)
	end,
	draw = function()
		MAIN_SCREEN:drawInsideRig()
		player:draw()
		star:draw()
		gui:draw()
		MAIN_SCREEN:stopDrawInsideRig()
	end,
	exit = function()
		Tape.log("debug", "Exit play state")
		player:restart()
		gui:remove()
	end,
})
