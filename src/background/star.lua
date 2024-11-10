local S = {}

local star_image = love.graphics.newImage("assets/sol.png")
local image_offset = 0
local star_image_movement = 90
local star_radius = 90
local star_draw_target = love.graphics.newCanvas(star_radius * 2, star_radius * 2)

function S:update(dt)
	image_offset = image_offset + (star_image_movement * dt)
	if image_offset >= 360 then
		image_offset = 0
	end
end

function S:draw()
	local current_render_target = love.graphics.getCanvas()
	love.graphics.setCanvas({
		star_draw_target,
		stencil = true,
	})
	love.graphics.stencil(function()
		love.graphics.circle("fill", star_radius, star_radius, star_radius)
	end, "increment")

	love.graphics.setStencilTest("gequal", 1)
	love.graphics.draw(star_image, image_offset, 0)
	love.graphics.draw(star_image, image_offset - 360, 0)

	love.graphics.setStencilTest()
	love.graphics.setCanvas(current_render_target)

	love.graphics.draw(star_draw_target, (GAME_WIDTH / 2) - star_radius, (GAME_HEIGHT / 2) - star_radius)
end

return S
