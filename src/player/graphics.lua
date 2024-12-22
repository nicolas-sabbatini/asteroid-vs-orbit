local G = {}

local image = love.graphics.newImage("assets/tierra.png")
local image_offset = 0
local image_movement = 44
local draw_target = love.graphics.newCanvas(44, 44)
local offset = 44 / 2

function G:update(dt)
	image_offset = image_offset + (image_movement * dt)
	if image_offset >= 88 then
		image_offset = 0
	end
end

function G:draw(x, y, rotation)
	local current_render_target = love.graphics.getCanvas()
	love.graphics.setCanvas({
		draw_target,
		stencil = true,
	})
	love.graphics.stencil(function()
		love.graphics.circle("fill", offset, offset, offset)
	end, "increment")
	love.graphics.setStencilTest("gequal", 1)
	love.graphics.draw(image, image_offset, 0)
	love.graphics.draw(image, image_offset - 88, 0)
	love.graphics.setStencilTest()
	love.graphics.setCanvas(current_render_target)

	love.graphics.draw(draw_target, x, y, rotation, 1, 1, offset, offset)
end

return G
