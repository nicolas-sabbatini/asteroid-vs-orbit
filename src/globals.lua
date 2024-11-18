GAME_WIDTH = 1920
GAME_HEIGHT = 1080

-- Palette
local rgb = require("vendors.rgb")
BACKGROUND = rgb.exaToTable(0x181425)

-- Camera
local letterbox = require("vendors.letterbox")
MAIN_SCREEN = letterbox.newLetterbox({
	type = "normal",
	width = GAME_WIDTH,
	height = GAME_HEIGHT,
} --[[@as letterbox.Upscale.Normal]], {
	width = GAME_WIDTH,
	height = GAME_HEIGHT,
})

-- Keys
KEYS = require("vendors.simple_keyboard")
KEYS:keyBind({ "space" })
