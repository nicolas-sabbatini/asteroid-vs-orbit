local main_menu = require("gui.main_menu")
local player = require("player")
local star = require("star")

love.states.addState("main_menu", {
	enter = function()
		Tape.log("debug", "Enter main menu state")
		main_menu:append()
	end,
	update = function(dt)
		main_menu:update()
		star:update(dt)
		player:updateGraphics(dt)
	end,
	draw = function()
		MAIN_SCREEN:drawInsideRig()
		player:draw()
		star:draw()
		MAIN_SCREEN:stopDrawInsideRig()
		main_menu:draw()
	end,
	exit = function()
		Tape.log("debug", "Exit main menu state")
		main_menu:remove()
	end,
})
