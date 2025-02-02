local graphics = require("asteroid.graphics")
local factory = require("asteroid.entity")

local asteroids = {}
local heat = 0
local heat_generation = 1
local heat_level = 1
local time = 0

local A = {}

function A:restart()
	asteroids = {}
	heat = 0
	heat_generation = 1
	heat_level = 1
	time = 0
end

local function update_heat(dt)
	heat = heat + heat_generation * dt
	if heat >= 5 then
		heat = heat - 5
		table.insert(asteroids, factory())
		Tape.log("debug", "Spawn asteroid, total = %d", #asteroids)
	end
	time = time + dt
	if math.log(heat_level) * 10 + 5 < time then
		time = 0
		heat_level = heat_level + 1
		heat_generation = heat_generation + math.log(heat_level) * 0.5
		Tape.log(
			"debug",
			"More heat, lvl change at %f, level = %d, generation = %f",
			math.log(heat_level) * 10 + 5,
			heat_level,
			heat_generation
		)
	end
end

function A:update(dt)
	graphics:update(dt)
	update_heat(dt)

	local free = {}
	for k, a in pairs(asteroids) do
		if a:update(dt) then
			table.insert(free, k)
		end
	end
	for i = #free, 1, -1 do
		table.remove(asteroids, free[i])
	end
end

function A:draw()
	for _, a in pairs(asteroids) do
		a:draw(graphics.draw_target)
	end
end

function A:get()
	return asteroids
end

return A
