local rgb = require("vendors.rgb")

local B = {}

local particle = love.graphics.newImage("assets/pixel.png")
particle:setFilter("nearest", "nearest")

local particle_system = love.graphics.newParticleSystem(particle, 150)
particle_system:setParticleLifetime(2, 5)
particle_system:setEmissionRate(30)
particle_system:setEmissionArea("uniform", GAME_WIDTH, GAME_HEIGHT)
particle_system:setColors(
	rgb.alphaExaToTable(0xffffff00),
	rgb.alphaExaToTable(0xffffffff),
	rgb.alphaExaToTable(0xffffff00)
)
particle_system:setSizes(0, 1.1, 1, 0)

for _ = 1, 10 do
	particle_system:update(0.2)
end

function B:update(dt)
	particle_system:update(dt)
end

function B:draw()
	love.graphics.draw(particle_system, 0, 0)
end

return B
