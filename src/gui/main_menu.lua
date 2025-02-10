local gui_name = "main_menu"

local main_menu_size_x = GAME_WIDTH
local main_menu_size_y = GAME_HEIGHT / 2 - 180

local font = love.graphics.newFont("assets/fonts/NewHiScore.ttf", 60)
local font_help = love.graphics.newFont(15)

local help_size = font_help:getHeight() + 20

local texts = {}
if OS == "Web" then
	texts = {
		"QUICK PLAY",
		"STORE",
		"OPTIONS",
	}
else
	texts = {
		"QUICK PLAY",
		"STORE",
		"OPTIONS",
		"EXIT",
	}
end
local text_options = #texts
local selected = 0
local left = #texts - 1
local right = 1

local menu = LETTERBOX.newLetterbox({
	type = "constant",
	x = 0,
	y = GAME_HEIGHT - main_menu_size_y,
} --[[@as letterbox.Upscale.Constant]], {
	width = main_menu_size_x,
	height = main_menu_size_y,
}, gui_name)

local M = {}

function M:update()
	if KEYS:justPressed("left") then
		selected = math.fmod(text_options + selected - 1, text_options)
		left = math.fmod(text_options + selected - 1, text_options)
		right = math.fmod(text_options + selected + 1, text_options)
	elseif KEYS:justPressed("right") then
		selected = math.fmod(text_options + selected + 1, text_options)
		left = math.fmod(text_options + selected - 1, text_options)
		right = math.fmod(text_options + selected + 1, text_options)
	elseif KEYS:justPressed("space") then
		local is_selected = selected + 1
		if texts[is_selected] == "QUICK PLAY" then
			love.states.swichState("play")
		elseif texts[is_selected] == "STORE" then
			love.states.swichState("store")
		elseif texts[is_selected] == "OPTIONS" then
			love.states.swichState("options")
		elseif texts[is_selected] == "EXIT" then
			love.event.push("quit")
		end
	end
end

function M:draw()
	menu:drawInsideRig()
	love.graphics.clear()
	love.graphics.setColor(STYLE.bc)
	love.graphics.rectangle("fill", 0, 0, main_menu_size_x, main_menu_size_y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("< " .. texts[selected + 1] .. " >", font, 0, 50, main_menu_size_x, "center")
	love.graphics.printf(texts[left + 1], font, 0, 100, main_menu_size_x / 2, "center")
	love.graphics.printf(texts[right + 1], font, main_menu_size_x / 2, 100, main_menu_size_x / 2, "center")
	love.graphics.printf("`SPACE` TO SELECT", font_help, 0, main_menu_size_y - help_size, main_menu_size_x, "center")
	menu:stopDrawInsideRig()
end

function M:append()
	MAIN_SCREEN:addChildren(menu)
end

function M:remove()
	MAIN_SCREEN:removeChildren(gui_name)
end

return M
