local rgb = require("vendors.rgb")

local B = {}

local particle = love.graphics.newImage("assets/pixel.png")
particle:setFilter("nearest", "nearest")

local particleSystem = love.graphics.newParticleSystem(particle, 150)
particleSystem:setParticleLifetime(2, 5)
particleSystem:setEmissionRate(30)
particleSystem:setEmissionArea("uniform", GAME_WIDTH, GAME_HEIGHT)
particleSystem:setColors(
	rgb.alphaExaToTable(0xffffff00),
	rgb.alphaExaToTable(0xffffffff),
	rgb.alphaExaToTable(0xffffff00)
)
particleSystem:setSizes(0, 1.1, 1, 0)

for _ = 1, 10 do
	particleSystem:update(0.2)
end

function B:update(dt)
	particleSystem:update(dt)
end

function B:draw()
	love.graphics.draw(particleSystem, 0, 0)
end

return B
