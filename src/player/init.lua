local graphics = require("player.graphics")

local P = {}

-- General variables
local center_width = GAME_WIDTH / 2
local center_height = GAME_HEIGHT / 2

-- Const gameplay
local max_distance = 400 -- Distance to center of star
local min_dinstance = 90 -- Distance to center of star
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

function P:restart()
	rotation = 0
	distance = max_distance / 2 + size
	rotation_speed = 0
	score = 0
end

function P:update(dt)
	if STATE == "play" then
		if KEYS:isDown("space") then
			distance = distance + jump_speed * dt
		-- TODO: DBG
		else
			distance = distance - fall_speed * dt
			-- END
		end
		if distance < min_dinstance then
			-- TODO: Kill
			distance = min_dinstance
		-- END
		elseif distance > max_distance then
			distance = max_distance
		end
		rotation_speed = max_rotation_speed - rotation_slop_change * (distance - min_dinstance)

		score = score + 10
		love.event.push("updateScore", score)
	end

	rotation = rotation + (dt * rotation_speed)
	x = center_width - math.sin(-rotation) * distance
	y = center_height - math.cos(-rotation) * distance
	graphics:update(dt)
end

function P:draw()
	love.graphics.circle("line", center_width, center_height, max_distance)
	graphics:draw(x, y, rotation)
end

P:restart()

return P
