local main_menu = require("gui.main_menu")
local score = require("gui.score")

local G = {}

function G:update(dt)
	main_menu:update(dt)
	score:update(dt)
end

function G:draw()
	main_menu:draw()
	score:draw()
end

return G
