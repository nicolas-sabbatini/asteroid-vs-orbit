local common = require("asteroid.common")

local asteroids = {}
local heat = 10

local A = {}

function A:restart()
	asteroids = {}
end

function A:update(dt) end

function A:draw() end

return A
