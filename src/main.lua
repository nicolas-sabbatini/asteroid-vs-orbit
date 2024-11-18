require("globals")

local background = require("background")
local player = require("player")
local star = require("star")

love.math.setRandomSeed(love.timer.getTime())

function love.resize(w, h)
	MAIN_SCREEN:resizeParent({ width = w, height = h })
end

function love.load() end

function love.update(dt)
	KEYS:updateInput()

	background:update(dt)
	player:update(dt)
	star:update(dt)
end

function love.draw()
	MAIN_SCREEN:drawInsideRig()
	love.graphics.clear(BACKGROUND)
	background:draw()
	player:draw()
	star:draw()
	MAIN_SCREEN:stopDrawInsideRig()

	-- Draw to screen
	love.graphics.clear(0.0, 0.0, 0.0, 1.0)
	MAIN_SCREEN:draw()
end
