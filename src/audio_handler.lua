local background = love.audio.newSource("assets/night-city-53936.wav", "stream")
background:setLooping(true)
background:play()

local score_sound = love.audio.newSource("assets/correct3-95630.wav", "static")

local A = {}

function A:play_score_sound()
	score_sound:play()
end

return A
