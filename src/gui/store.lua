local gui_name = "store"

local store_size_x = GAME_WIDTH
local store_size_y = GAME_HEIGHT / 2 - 180

local font = love.graphics.newFont("assets/fonts/NewHiScore.ttf", 60)
local text_offset_y = (store_size_y - font:getHeight()) / 2

local score_board = LETTERBOX.newLetterbox({
	type = "constant",
	x = 0,
	y = GAME_HEIGHT - store_size_y,
} --[[@as letterbox.Upscale.Constant]], {
	width = store_size_x,
	height = store_size_y,
}, gui_name)

local S = {}

function S:draw()
	score_board:drawInsideRig()
	love.graphics.clear()
	love.graphics.setColor(STYLE.bc)
	love.graphics.rectangle("fill", 0, 0, store_size_x, store_size_y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("NOT IMPLEMENTED", font, 0, 50, store_size_x, "center")
	score_board:stopDrawInsideRig()
end

function S:update()
	if KEYS:justPressed("space") then
		love.states.swichState("main_menu")
	end
end

function S:append()
	MAIN_SCREEN:addChildren(score_board)
end

function S:remove()
	MAIN_SCREEN:removeChildren(gui_name)
end

return S
