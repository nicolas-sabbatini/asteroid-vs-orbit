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

function love.resize()
	-- Si bien esta funcion trae el w, h hay casos en los que se buguea.
	-- ya que calculamos unas cosas en el globals si el systema despues detecta que la config
	-- es más grande que la pantalla se hace un resize pero no resizea de verdad
	local w, h = love.graphics.getDimensions()
	MAIN_SCREEN:resizeParent({ width = w, height = h })
end

function love.load()
	love.states.pushState("base")
	love.states.pushState("main_menu")

	local shader_code = love.filesystem.read("shaders/ctr.glsl")
	shader = love.graphics.newShader(shader_code)
	shader:send("iResolution", { GAME_WIDTH, GAME_HEIGHT })
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
