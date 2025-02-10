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

local function update_shader()
	local w = math.floor(MAIN_SCREEN.scale.x * GAME_WIDTH)
	local h = math.floor(MAIN_SCREEN.scale.y * GAME_HEIGHT)
	shader:send("iResolution", { w, h })
end

function love.resize()
	-- Si bien esta funcion trae el w, h hay casos en los que se buguea.
	-- ya que calculamos unas cosas en el globals si el systema despues detecta que la config
	-- es más grande que la pantalla se hace un resize pero no resizea de verdad
	local w, h = love.graphics.getDimensions()
	MAIN_SCREEN:resizeParent({ width = w, height = h })
	update_shader()
end

function love.load()
	love.states.pushState("base")
	love.states.pushState("main_menu")

	local shader_code = love.filesystem.read("shaders/ctr.glsl")
	shader = love.graphics.newShader(shader_code)
	update_shader()
	MAIN_SCREEN:pushPostProcessing(shader)
end

function love.update(dt)
	KEYS:updateInput()
	background:update(dt)
end

function love.draw()
	love.graphics.clear(0.0, 0.0, 0.0, 1.0)
	MAIN_SCREEN:draw()
end
