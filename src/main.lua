require("globals")
require("vendors.state_manager")
require("handlers")
require("save_system")

love.math.setRandomSeed(os.time())

require("states.base")
require("states.main_menu")
require("states.play")
require("states.game_over")

local background = require("background")

function love.resize(w, h)
	MAIN_SCREEN:resizeParent({ width = w, height = h })
end

function love.load()
	love.states.pushState("base")
	love.states.pushState("main_menu")
end

function love.update(dt)
	KEYS:updateInput()
	background:update(dt)
end

function love.draw()
	love.graphics.clear(0.0, 0.0, 0.0, 1.0)
	MAIN_SCREEN:draw()
end
