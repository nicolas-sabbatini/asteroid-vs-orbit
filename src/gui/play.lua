local score_size_x = GAME_WIDTH * 0.5
local score_size_y = GAME_HEIGHT * 0.1
local score = 0

local font = love.graphics.newFont("assets/fonts/NewHiScore.ttf", 80)
local text_offset_y = (score_size_y - font:getHeight()) / 2

local score_board = LETTERBOX.newLetterbox({
	type = "constant",
	x = (GAME_WIDTH - score_size_x) / 2,
	y = text_offset_y,
} --[[@as letterbox.Upscale.Constant]], {
	width = score_size_x,
	height = score_size_y,
})

MAIN_SCREEN:addChildren(score_board)

local S = {}

function S:update(dt)
	if STATE ~= "play" then
		score_board.visible = false
		return
	end
	score_board.visible = true
end

function S:draw()
	score_board:drawInsideRig()
	love.graphics.clear()
	love.graphics.printf(tostring(score), font, 0, 0, score_size_x, "center")
	score_board:stopDrawInsideRig()
end

function S:updateScore(newScore)
	score = newScore
end

return S
