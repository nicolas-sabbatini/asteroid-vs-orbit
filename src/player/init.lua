local graphics = require("player.graphics")

local P = {}

-- General variables
local center_width = GAME_WIDTH / 2
local center_height = GAME_HEIGHT / 2

-- Const gameplay
local max_distance = 400 -- Distance to center of star
local min_dinstance = 100 -- Distance to center of star
local max_rotation_speed = 2.5
local min_rotation_speed = 0.5
local rotation_slop_change = (max_rotation_speed - min_rotation_speed) / (max_distance - min_dinstance)
local fall_speed = 100
local jump_speed = 150

-- Player variables
local size = 44
local distance = max_distance * 0.5 - size / 2
local rotation_speed = 0
local rotation = 0
local x = 0
local y = 0
local score = 0
local can_score = false

function P:restart()
	rotation = 0
	distance = max_distance / 2 + size
	rotation_speed = 0
	score = 0
	can_score = false
	love.event.push("updateScore", score)

	x = center_width - math.sin(-rotation) * distance
	y = center_height - math.cos(-rotation) * distance
end

function P:updateMuvement(dt)
	if KEYS:isDown("space") then
		distance = distance + jump_speed * dt
	else
		distance = distance - fall_speed * dt
	end

	if distance < min_dinstance then
		love.states.swichState("game_over", score)
	elseif distance > max_distance then
		distance = max_distance
	end

	rotation_speed = max_rotation_speed - rotation_slop_change * (distance - min_dinstance)
	rotation = rotation + (dt * rotation_speed)
	local sin = math.sin(-rotation)
	local cos = math.cos(-rotation)
	x = center_width - sin * distance
	y = center_height - cos * distance

	if can_score and cos > 0 and sin < 0 then
		score = score + 1
		love.event.push("updateScore", score)
		can_score = false
	end
	if not can_score and cos > 0 and sin > 0 then
		can_score = true
	end
end

function P:updateGraphics(dt)
	graphics:update(dt)
end

function P:draw()
	graphics:draw(x, y, rotation)
end

P:restart()

return P
