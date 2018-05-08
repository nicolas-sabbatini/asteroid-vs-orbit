local game = {}

local key = require 'libs/simpleKey'
local comets = require('game/comets')

local HighScore, score, b, font, backgraund, star, planet, state

local function saveHighScore()
    love.filesystem.write('score', 'return ' .. HighScore)
end

-- Debug function
local function endGame()
    state = 'menu'
    comets:restart()
    planet:restart()
    if score > HighScore then
        HighScore = score
        saveHighScore()
    end
end

function game:load()
    -- Initial game state
    state = 'menu'
    -- Score
    HighScore = 0
    score = 0
    b = false
    if love.filesystem.getInfo('score') then
        HighScore = love.filesystem.load('score')
        HighScore = HighScore()
    end
    -- Leters
    font = love.graphics.newFont(16)
    love.graphics.setFont(font)
    -- particles for all emiters
    local particle = love.graphics.newImage('assets/pixel.png')
    particle:setFilter('nearest','nearest')
    -- Backgraund starts
    backgraund = {}
    backgraund.ps = love.graphics.newParticleSystem(particle, 60)
    backgraund.ps:setParticleLifetime(2, 5)
    backgraund.ps:setEmissionRate(60)
    backgraund.ps:setEmissionArea('uniform', getWw(), getWh())
    --                      r  g  b  a r1 g1 b1 a1  r2 g2 b2 a2
    backgraund.ps:setColors(1, 1, 1, 0, 1, 1, 1,0.5, 1, 1, 1, 0) 
    backgraund.ps:setSizeVariation(1)
    backgraund.ps:update(1)
    -- Start
    star = {}
    star.x = getWw()/2
    star.y = getWh()/2
    star.img = love.graphics.newImage('assets/sol.png')
    star.img:setFilter('nearest','nearest')
    star.ps = love.graphics.newParticleSystem(particle, 500)
    star.ps:setParticleLifetime(1, 2)
    star.ps:setEmissionRate(210)
    star.ps:setEmissionArea('ellipse', 40, 40)
    --                r  g  b  a r1 g1 b1 a1
    star.ps:setColors(1, 1, 0, 1, 1, 0, 0, 1)
    star.ps:update(1)
    -- Planet
    planet = {}
    function planet:restart()
        planet.alive = true
        planet.a = 0
        planet.d = 220
        planet.s = 2
        planet.x = star.x + math.sin(planet.a) * planet.d
        planet.y = star.y + math.cos(planet.a) * planet.d
    end
    planet:restart()
end

function game:update(dt)
    -- Bakgraund
    backgraund.ps:update(dt)
    -- Star
    star.ps:update(dt)
    if state == 'game' then
        -- Comets
        comets:update(dt, star, planet)
        -- Player movement
        if key:checkDown('space') then planet.d = planet.d + (150 * dt)
        else planet.d = planet.d - (100 * dt) end
        if planet.d > 240 then planet.d = 240 end
        if planet.d <  50 then planet.alive = false end
        -- Player angle
        planet.a = planet.a + (dt * planet.s)
        planet.x = star.x + math.sin(planet.a) * planet.d
        planet.y = star.y + math.cos(planet.a) * planet.d
        -- Avoid overflow of planet.a, tray
        if (math.sin(planet.a) == 0) and (math.cos(planet.a) == 1) then
            planet.a = 0
        end
        if (planet.x > star.x) and (planet.y > star.y) and b then
            b = false
            score = score + 1
        elseif (planet.x < star.x) and (planet.y < star.y) then
            b = true
        end
        planet.s = (240 /planet.d) ^ 1.2
        if not planet.alive then endGame() end
    elseif state == 'menu' then
        if key:checkDown('space') then state = 'game' end
        if key:checkDown('q') then love.event.quit() end
    end
end

function game:draw()
    -- Backgraund
    love.graphics.draw(backgraund.ps, 0, 0)
    -- Comets
    comets:draw()
    -- Star
    love.graphics.circle('line', star.x, star.y, 240)
    love.graphics.draw(star.img, star.x - 40, star.y - 40)
    love.graphics.draw(star.ps, star.x, star.y)
    -- Score
    love.graphics.print('Score: ' .. score)
    -- Planet
    love.graphics.setColor(0.001,1,0.5)
    love.graphics.circle('fill', planet.x, planet.y, 10)
    love.graphics.setColor(1,1,1)
end

return game