require("globals")
require("vendors.state_manager")
require("handlers")
require("save_system")
require("audio_handler")

love.math.setRandomSeed(os.time())

require("states.base")
require("states.game_over")
require("states.main_menu")
require("states.options")
require("states.play")
require("states.store")

local background = require("background")
local shader

function love.resize(w, h)
	MAIN_SCREEN:resizeParent({ width = w, height = h })
	local shader_code = love.filesystem.read("shaders/ctr.glsl")
	shader = love.graphics.newShader(shader_code)
	shader:send("iResolution", { GAME_WIDTH, GAME_HEIGHT })
	MAIN_SCREEN:pushPostProcessing(shader)
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
