local play = require("gui.play")
local audio = require("audio_handler")

function love.handlers.updateScore(score)
	play:updateScore(score)
end

function love.handlers.playScoreSound()
	audio:play_score_sound()
end
