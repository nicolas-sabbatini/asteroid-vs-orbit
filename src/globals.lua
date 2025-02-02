GAME_WIDTH = 1920
GAME_HEIGHT = 1080

HIGH_SCORE = 0

-- Palette
local rgb = require("vendors.rgb")
BACKGROUND = rgb.exaToTable(0x181425)

-- Camera
local _, _, flags = love.window.getMode()
local monitor_width, monitor_height = love.window.getDesktopDimensions(flags.display)
local start_width, start_height = love.graphics.getDimensions()
monitor_width = monitor_width / 2
monitor_height = monitor_height / 2
if start_width > monitor_width or start_height > monitor_height then
	local ratio = math.min(monitor_width / start_width, monitor_height, start_height)
	start_width = start_width * ratio
	start_height = start_height * ratio
	love.window.setMode(start_width, start_height, flags)
end

LETTERBOX = require("vendors.letterbox")
MAIN_SCREEN = LETTERBOX.newLetterbox({
	type = "pixel-perfect",
	width = start_width,
	height = start_height,
} --[[@as letterbox.Upscale.PixelPerfect]], {
	width = GAME_WIDTH,
	height = GAME_HEIGHT,
})

-- Keys
KEYS = require("vendors.simple_keyboard")
KEYS:keyBind({ "space", "left", "right" })

-- Tape
require("vendors.tape")
Tape.init("console")

-- GUI
STYLE = {
	bc = rgb.exaToTable(0x222222),
	br = 15,
}
