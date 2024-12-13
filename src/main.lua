require("globals")

local background = require("background")
local player = require("player")
local star = require("star")

function love.resize(w, h)
	MAIN_SCREEN:resizeParent({ width = w, height = h })
end

function love.load()
	local seed = os.time()
	Tape.log("debug", "Current seed %d", seed)
	love.math.setRandomSeed(seed)
end

function love.update(dt)
	KEYS:updateInput()
	background:update(dt)
	star:update(dt)
	player:update(dt)
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
