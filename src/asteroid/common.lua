local image = love.graphics.newImage("assets/tierra.png")
local size = 44
local image_offset = 0
local image_movement = size
local draw_target = love.graphics.newCanvas(size, size)

local F = {}

function F:newAsteroid() end

return F
