local S = {}

local img = love.graphics.newImage("assets/sol.png")
local canvas = love.graphics.newCanvas(180, 180)
local offset = 0
local speed = 90

local function myStencilFunction()
	love.graphics.circle("fill", 90, 90, 90)
end

function S.update(self, dt)
	offset = offset + (speed * dt)
	if offset >= 360 then
		offset = 0
	end
end

function S.draw(self)
	local current = love.graphics.getCanvas()

	love.graphics.setCanvas({
		canvas,
		stencil = true,
	})
	love.graphics.stencil(myStencilFunction, "increment")
	love.graphics.setStencilTest("gequal", 1)
	love.graphics.draw(img, offset, 0)
	love.graphics.draw(img, offset - 360, 0)
	love.graphics.setStencilTest()
	love.graphics.setCanvas(current)

	love.graphics.draw(canvas, (GAME_WIDTH - 180) / 2, (GAME_HEIGHT - 180) / 2)
end

return S
