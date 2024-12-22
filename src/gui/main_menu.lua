local main_menu_size_x = GAME_WIDTH * 0.7
local main_menu_size_y = GAME_HEIGHT

local menu = LETTERBOX.newLetterbox({
	type = "constant",
	x = (GAME_WIDTH - main_menu_size_x) / 2,
	y = (GAME_HEIGHT - main_menu_size_y) / 2,
} --[[@as letterbox.Upscale.Constant]], {
	width = main_menu_size_x,
	height = main_menu_size_y,
})

MAIN_SCREEN:addChildren(menu)

local M = {}

function M:update(dt)
	if STATE ~= "main_menu" then
		menu.visible = false
		return
	end
	menu.visible = true
	if KEYS:justPressed("space") then
		STATE = "play"
	end
end

function M:draw()
	menu:drawInsideRig()
	love.graphics.rectangle("line", 0, 0, main_menu_size_x, main_menu_size_y, 5, 5)
	menu:stopDrawInsideRig()
end

return M
