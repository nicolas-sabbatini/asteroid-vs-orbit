local gui_name = "options"

local options_size_x = GAME_WIDTH
local options_size_y = GAME_HEIGHT / 2 - 180

local font = love.graphics.newFont("assets/fonts/NewHiScore.ttf", 60)
local text_offset_y = (options_size_y - font:getHeight()) / 2

local score_board = LETTERBOX.newLetterbox({
	type = "constant",
	x = 0,
	y = GAME_HEIGHT - options_size_y,
} --[[@as letterbox.Upscale.Constant]], {
	width = options_size_x,
	height = options_size_y,
}, gui_name)

local O = {}

function O:draw()
	score_board:drawInsideRig()
	love.graphics.clear()
	love.graphics.setColor(STYLE.bc)
	love.graphics.rectangle("fill", 0, 0, options_size_x, options_size_y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("NOT IMPLEMENTED", font, 0, 50, options_size_x, "center")
	score_board:stopDrawInsideRig()
end

function O:update()
	if KEYS:justPressed("space") then
		love.states.swichState("main_menu")
	end
end

function O:append()
	MAIN_SCREEN:addChildren(score_board)
end

function O:remove()
	MAIN_SCREEN:removeChildren(gui_name)
end

return O
