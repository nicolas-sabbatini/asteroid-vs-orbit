local background = require("background.background")
local star = require("background.star")

local S = {}

function S:update(dt)
	background:update(dt)
	star:update(dt)
end

function S:draw()
	background:draw()
	star:draw()
end

return S
