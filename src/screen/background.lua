local rgb = require("vendors.rgb")

local B = {}

local particle = love.graphics.newImage("assets/pixel.png")
particle:setFilter("nearest", "nearest")

B.particleSystem = love.graphics.newParticleSystem(particle, 150)
B.particleSystem:setParticleLifetime(2, 5)
B.particleSystem:setEmissionRate(30)
B.particleSystem:setEmissionArea("uniform", GAME_WIDTH, GAME_HEIGHT)
B.particleSystem:setColors(
	rgb.alphaExaToTable(0xffffff00),
	rgb.alphaExaToTable(0xffffffff),
	rgb.alphaExaToTable(0xffffff00)
)
B.particleSystem:setSizes(0, 1.1, 1, 0)

B.particleSystem:update(0.2)
B.particleSystem:update(0.2)
B.particleSystem:update(0.2)
B.particleSystem:update(0.2)
B.particleSystem:update(0.2)

function B.update(self, dt)
	self.particleSystem:update(dt)
end

function B.draw(self)
	love.graphics.draw(self.particleSystem, 0, 0)
end

return B
