local variables = require("player.variables")
local graphics = require("player.graphics")

local P = {}

-- General variables
local center_width = GAME_WIDTH / 2
local center_height = GAME_HEIGHT / 2

-- Const gameplay
local max_distance = 400
local min_dinstance = 90 -- Distance to center of star
local max_rotation_speed = 2.5
local min_rotation_speed = 0.5
local rotation_slop_change = (max_rotation_speed - min_rotation_speed) / (max_distance - min_dinstance)
local fall_speed = 100
local jump_speed = 150

-- Player variables
local distance = max_distance * 0.5 - variables.size / 2
local rotation_speed = 0

function P:restart()
	variables.rotation = 0
	distance = max_distance * 0.5 - variables.size / 2
	rotation_speed = 0
	variables.score = 0
end

function P:update(dt)
	if KEYS:isDown("space") then
		distance = distance + jump_speed * dt
	else
		distance = distance - fall_speed * dt
	end

	if distance < min_dinstance then
		distance = min_dinstance
	elseif distance > max_distance then
		distance = max_distance
	end

	rotation_speed = max_rotation_speed - rotation_slop_change * (distance - min_dinstance)

	variables.rotation = variables.rotation + (dt * rotation_speed)
	variables.x = center_width - math.sin(-variables.rotation) * distance
	variables.y = center_height - math.cos(-variables.rotation) * distance

	graphics:update(dt)
end

function P:draw()
	love.graphics.circle("line", center_width, center_height, max_distance)
	graphics:draw()
end

P:restart()

return P
