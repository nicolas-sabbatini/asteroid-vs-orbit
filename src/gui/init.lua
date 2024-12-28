local main_menu = require("gui.main_menu")
local play = require("gui.play")
local game_over = require("gui.game_over")

local G = {}

function G:update(dt)
	main_menu:update(dt)
	play:update(dt)
	game_over:update(dt)
end

function G:draw()
	main_menu:draw()
	play:draw()
	game_over:draw()
end

function love.handlers.updateScore(newScore)
	play:updateScore(newScore)
	game_over:updateScore(newScore)
end

return G
