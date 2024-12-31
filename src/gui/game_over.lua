local end_card_size_x = GAME_WIDTH
local end_card_size_y = GAME_HEIGHT / 2 - 180
local score = 0

local font = love.graphics.newFont("assets/fonts/NewHiScore.ttf", 60)
local font_score = love.graphics.newFont("assets/fonts/NewHiScore.ttf", 80)
local line_offset = font:getHeight() + 20

local text_options = 3
local texts = {
	"PLAY AGAIN",
	"MENU",
	"EXIT",
}
local OPTION_PLAY_AGAIN = 0
local OPTION_MENU = 1
local OPTION_EXIT = 2
local selected = 0
local left = 2
local right = 1

local gui_name_1 = "end_card_top"
local end_card_top = LETTERBOX.newLetterbox({
	type = "constant",
	x = 0,
	y = 0,
} --[[@as letterbox.Upscale.Constant]], {
	width = end_card_size_x,
	height = end_card_size_y,
}, gui_name_1)

local gui_name_2 = "end_card_bot"
local end_card_bot = LETTERBOX.newLetterbox({
	type = "constant",
	x = 0,
	y = GAME_HEIGHT - end_card_size_y,
} --[[@as letterbox.Upscale.Constant]], {
	width = end_card_size_x,
	height = end_card_size_y,
}, gui_name_2)

local G = {}

function G:update()
	if KEYS:justPressed("left") then
		selected = math.fmod(text_options + selected - 1, text_options)
		left = math.fmod(text_options + selected - 1, text_options)
		right = math.fmod(text_options + selected + 1, text_options)
	elseif KEYS:justPressed("right") then
		selected = math.fmod(text_options + selected + 1, text_options)
		left = math.fmod(text_options + selected - 1, text_options)
		right = math.fmod(text_options + selected + 1, text_options)
	elseif KEYS:justPressed("space") then
		if selected == OPTION_PLAY_AGAIN then
			love.states.swichState("play")
		end
		if selected == OPTION_MENU then
			love.states.swichState("main_menu")
		end
		if selected == OPTION_EXIT then
			love.event.push("quit")
		end
	end
end

function G:draw()
	end_card_top:drawInsideRig()
	love.graphics.clear()
	love.graphics.setColor(STYLE.bc)
	love.graphics.rectangle("fill", 0, 0, end_card_size_x, end_card_size_y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("YOUR FINAL SCORE", font, 0, end_card_size_y - line_offset * 4 + 10, end_card_size_x, "center")
	love.graphics.printf(
		tostring(score),
		font_score,
		0,
		end_card_size_y - line_offset * 3 - 5,
		end_card_size_x,
		"center"
	)
	love.graphics.printf("TOP SCORE", font, 0, end_card_size_y - line_offset * 2 + 10, end_card_size_x, "center")
	love.graphics.printf(
		tostring(HIGH_SCORE),
		font_score,
		0,
		end_card_size_y - line_offset - 5,
		end_card_size_x,
		"center"
	)
	end_card_top:stopDrawInsideRig()

	end_card_bot:drawInsideRig()
	love.graphics.clear()
	love.graphics.setColor(STYLE.bc)
	love.graphics.rectangle("fill", 0, 0, end_card_size_x, end_card_size_y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("< " .. texts[selected + 1] .. " >", font, 0, 50, end_card_size_x, "center")
	love.graphics.printf(texts[left + 1], font, 0, 100, end_card_size_x / 2, "center")
	love.graphics.printf(texts[right + 1], font, end_card_size_x / 2, 100, end_card_size_x / 2, "center")
	end_card_bot:stopDrawInsideRig()
end

function G:updateScore(newScore)
	score = newScore
end

function G:append()
	MAIN_SCREEN:addChildren(end_card_top)
	MAIN_SCREEN:addChildren(end_card_bot)
	selected = 0
	left = 2
	right = 1
end

function G:remove()
	MAIN_SCREEN:removeChildren(gui_name_1)
	MAIN_SCREEN:removeChildren(gui_name_2)
end

return G
