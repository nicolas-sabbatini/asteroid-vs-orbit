local gui = require("gui.store")
local player = require("player")
local star = require("star")

love.states.addState("store", {
	enter = function()
		Tape.log("debug", "Enter store state")
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
		Tape.log("debug", "Exit store state")
		gui:remove()
	end,
})
