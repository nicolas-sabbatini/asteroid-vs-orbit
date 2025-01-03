local gui = require("gui.options")
local player = require("player")
local star = require("star")

love.states.addState("options", {
	enter = function()
		Tape.log("debug", "Enter options state")
		gui:append()
	end,
	update = function(dt)
		gui:update()
	end,
	draw = function()
		MAIN_SCREEN:drawInsideRig()
		player:draw()
		star:draw()
		MAIN_SCREEN:stopDrawInsideRig()
		gui:draw()
	end,
	exit = function()
		Tape.log("debug", "Exit options state")
		gui:remove()
	end,
})
