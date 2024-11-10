local P = {}

function P:update(dt) end

function P:draw()
	love.graphics.circle("line", GAME_WIDTH / 2, GAME_HEIGHT / 2, 360)
end

return P
