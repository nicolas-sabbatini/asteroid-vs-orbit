local factory = require("asteroid.factory")

local asteroids = {}

local A = {}

function A:clear()
	asteroids = {}
end

function A:update(dt) end

function A:draw() end

return A
