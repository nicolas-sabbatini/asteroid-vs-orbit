GAME_WIDTH = 1920
GAME_HEIGHT = 1080

---@type "main_menu" | "play" | "game_over"
STATE = "main_menu"

-- Palette
local rgb = require("vendors.rgb")
BACKGROUND = rgb.exaToTable(0x181425)

-- Camera
LETTERBOX = require("vendors.letterbox")
MAIN_SCREEN = LETTERBOX.newLetterbox({
	type = "normal",
	width = GAME_WIDTH,
	height = GAME_HEIGHT,
} --[[@as letterbox.Upscale.Normal]], {
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
