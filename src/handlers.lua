local play = require("gui.play")

function love.handlers.updateScore(score)
	play:updateScore(score)
end
