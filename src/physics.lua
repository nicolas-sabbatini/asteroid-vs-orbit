local player = require("player")
local asteroids = require("asteroid")

local error_magin = 3

local P = {}

function P:calculate()
	local asteroid_list = asteroids:get()
	local p_x, p_y, p_size = player:getCordSize()
	for _, v in pairs(asteroid_list) do
		local a_x, a_y, a_size = v:getCordSize()
		local x = math.pow(p_x - a_x, 2)
		local y = math.pow(p_y - a_y, 2)
		local dist = math.sqrt(x + y)
		if a_size + p_size - error_magin > dist then
			player:kill()
			return
		elseif v.can_score and a_size + p_size + error_magin * 12 > dist then
			Tape.log("debug", "Score!")
			player:score()
			v.can_score = false
		end
	end
end

return P
