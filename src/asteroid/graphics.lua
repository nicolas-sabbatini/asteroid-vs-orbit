local image = love.graphics.newImage("assets/assteroid.png")
local size = 44
local image_offset = 0
local image_movement = size
local offset = 44 / 2

local G = {
	draw_target = love.graphics.newCanvas(size, size),
}

function G:update(dt)
	image_offset = image_offset + (image_movement * dt)
	if image_offset >= 88 then
		image_offset = 0
	end

	local current_render_target = love.graphics.getCanvas()
	love.graphics.setCanvas({
		self.draw_target,
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
end

return G
