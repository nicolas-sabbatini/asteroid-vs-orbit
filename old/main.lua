local state, switchState, extra
require 'init'
love.math.setRandomSeed(os.time())

-- Set a "good" random
for i = 1, 10 do
    love.math.random()
end

function love.load()
    initializeConfiguration()
    state = love.filesystem.load('game/main.lua')
    state = state()
    state:load()
end

function love.update(dt)
    -- Check if is need sate change
    switchState, extra = state:update(dt)
    if switchState ~= nil then
        state = love.filesystem.load(switchState .. '/main.lua')
        state = state()
        state:load(extra)
        -- Clean all previus state info
        collectgarbage('collect')
        -- Update the frist frame
        state:update(dt)
    end
end

function love.draw()
    -- Set a gloval camera
    love.graphics.push()
    love.graphics.scale(getScaleX(), getScaleY())
    state:draw()
    love.graphics.pop()
    --[[
    debugStatics()
    --]]
end
