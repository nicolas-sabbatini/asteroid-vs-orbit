local background = require("screen.background")
local star = require("screen.star")

local S = {}

function S.update(dt)
	background:update(dt)
	star:update(dt)
end

function S.draw()
	background:draw()
	star:draw()
end

return S
