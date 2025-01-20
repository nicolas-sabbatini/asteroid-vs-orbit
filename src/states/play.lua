local player = require("player")
local star = require("star")
local gui = require("gui.play")
local asteroids = require("asteroid")

love.states.addState("play", {
	enter = function()
		Tape.log("debug", "Enter play state")
		player:restart()
		gui:append()
		asteroids:restart()
	end,
	update = function(dt)
		star:update(dt)
		player:updateMovement(dt)
		player:updateGraphics(dt)
		asteroids:update(dt)
	end,
	draw = function()
		MAIN_SCREEN:drawInsideRig()
		player:draw()
		asteroids:draw()
		star:draw()
		gui:draw()
		MAIN_SCREEN:stopDrawInsideRig()
	end,
	exit = function()
		Tape.log("debug", "Exit play state")
		asteroids:restart()
		player:restart()
		gui:remove()
	end,
})
