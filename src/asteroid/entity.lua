local rgb = require("vendors.rgb")

local Asteroid = {}

local tau = math.pi * 2

local center_width = GAME_WIDTH / 2
local center_height = GAME_HEIGHT / 2
local draw_offset = 44 / 2

local particle = love.graphics.newImage("assets/pixel.png")
particle:setFilter("nearest", "nearest")

function Asteroid:update(dt)
	self.distance = self.distance - self.speed * dt
	self.angle = self.angle + self.angle_speed * dt
	self.particle_system:update(dt)

	if self.distance < 0 then
		return true
	end
	self:updatePosition()
end

function Asteroid:updatePosition()
	local sin = math.sin(-self.rotation)
	local cos = math.cos(-self.rotation)
	self.x = center_width - sin * self.distance
	self.y = center_height - cos * self.distance
end

function Asteroid:draw(img)
	love.graphics.draw(img, self.x, self.y, self.rotation, 1, 1, draw_offset, draw_offset)
	love.graphics.draw(self.particle_system, self.x, self.y)
end

return function()
	local rotation = love.math.random() * tau
	local sin = math.sin(-rotation)
	local cos = math.cos(-rotation)

	local distance = GAME_WIDTH * 0.6 + draw_offset
	local x = center_width - sin * distance
	local y = center_height - cos * distance

	local speed = love.math.random(150, 350)

	local particle_system = love.graphics.newParticleSystem(particle, 120)
	particle_system:setParticleLifetime(0.5, 1.5)
	particle_system:setEmissionRate(50)
	particle_system:setEmissionArea("ellipse", 20, 20)
	particle_system:setLinearAcceleration((-0.5 * speed) * sin, (-0.5 * speed) * cos)
	particle_system:setColors(
		rgb.alphaExaToTable(0x733e39ff),
		rgb.alphaExaToTable(0xb86f50ff),
		rgb.alphaExaToTable(0xb86f5000)
	)
	particle_system:setSizes(1.3, 0)

	local new_asteroid = setmetatable({
		distance = distance,
		angle = love.math.random() * tau,
		angle_speed = (love.math.random() * tau),
		speed = speed,
		x = x,
		y = y,
		rotation = rotation,
		particle_system = particle_system,
	}, { __index = Asteroid })

	return new_asteroid
end
