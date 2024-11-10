require("globals")

local screen = require("background")
local player = require("player")

love.math.setRandomSeed(love.timer.getTime())

function love.resize(w, h)
	MAIN_SCREEN:resizeParent({ width = w, height = h })
end

function love.load() end

function love.update(dt)
	screen:update(dt)
	player:update(dt)
end

function love.draw()
	MAIN_SCREEN:drawInsideRig()
	love.graphics.clear(BACKGROUND)
	screen:draw()
	player:draw()
	MAIN_SCREEN:stopDrawInsideRig()

	-- Draw to screen
	love.graphics.clear(0.0, 0.0, 0.0, 1.0)
	MAIN_SCREEN:draw()
end
