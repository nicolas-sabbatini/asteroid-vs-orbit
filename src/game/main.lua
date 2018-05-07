local game = {}

local key = require 'libs/simpleKey'

local HighScore, score, b, font,  backgraund, star, planet, comets

local function saveHighScore()
    love.filesystem.write('score', 'return ' .. data)
end

function game:load()

    HighScore = 0
    score = 0
    b = false
    if love.filesystem.getInfo('score') then
        HighScore = love.filesystem.load('score')
        HighScore = HighScore()
    end

    font = love.graphics.newFont(16)
    love.graphics.setFont(font)

    local particle = love.graphics.newImage('assets/pixel.png')
    particle:setFilter('nearest','nearest')

    backgraund = {}
    backgraund.ps = love.graphics.newParticleSystem(particle, 60)
    backgraund.ps:setParticleLifetime(2, 5)
    backgraund.ps:setEmissionRate(60)
    backgraund.ps:setEmissionArea('uniform', getWw(), getWh())
    --                      r  g  b  a r1 g1 b1 a1  r2 g2 b2 a2
    backgraund.ps:setColors(1, 1, 1, 0, 1, 1, 1,0.5, 1, 1, 1, 0) 
    backgraund.ps:setSizeVariation(1)
    backgraund.ps:update(1)


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


    planet = {}
    planet.a = 0
    planet.d = 220
    planet.s = 2
    planet.x = star.x + planet.d
    planet.y = star.y + planet.d
    
    comets = {}
    comets.c = {}
    comets.max = 5
    comets.time = 0
    function comets:restart()
        comets.c = {}
        comets.max = 5
        comets.time = 0
    end
    function comets:new()
        local c = {}
        local l = math.random(1,4)
        if l == 1 then
            c.x = -10
            c.y = math.random(0, getWh() + 10) - 10
        elseif l == 2 then
            c.x = math.random(0, getWw() + 10) - 10
            c.y = 610
        elseif l == 3 then
            c.x = getWw() + 10
            c.y = math.random(0, getWh() + 10) - 10
        else
            c.x = math.random(0, getWw() + 10) - 10
            c.y = -10
        end
        c.v = math.random(150, 40)
        table.insert(comets.c, c)
    end
    function comets:update(dt)
        comets.time = comets.time + dt
        if comets.time > comets.max then
            comets:new()
            if comets.max > 0.2 then
                comets.max = comets.max - 0.1
            end
            comets.time = 0
        end
        for _, c in pairs(comets.c) do
            
            if math.sqrt(((c.x+planet.x)^2 + (c.y+planet.y)^2) < 10 then
                os.exit()
            end
        end
    end

end

function game:update(dt)

    backgraund.ps:update(dt)
    star.ps:update(dt)

    comets:update(dt)

    if key:checkDown('space') then planet.d = planet.d + (150 * dt)
    else planet.d = planet.d - (100 * dt) end
    if planet.d > 240 then planet.d = 240 end
    if planet.d <  50 then os.exit() end

    planet.a = planet.a + (dt * planet.s)
    planet.x = star.x + math.sin(planet.a) * planet.d
    planet.y = star.y + math.cos(planet.a) * planet.d
    -- Avoid overflow of planet.a, tray
    if (math.sin(planet.a) == 0) and (math.cos(planet.a) == 1) then
        planet.a = 0
    end

    if (planet.x < star.x) and (planet.y > star.y) and b then
        b = false
        score = score + 1
    elseif (planet.x < star.x) and (planet.y < star.y) then
        b = true
    end

    planet.s = (240 /planet.d) ^ 1.2

end

function game:draw()
    love.graphics.draw(backgraund.ps, 0, 0)
    love.graphics.circle('line', star.x, star.y, 240)
    love.graphics.setColor(0.001,1,0.5)
    love.graphics.circle('fill', planet.x, planet.y, 10)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(star.img, star.x - 40, star.y - 40)
    love.graphics.draw(star.ps, star.x, star.y)
    love.graphics.print('Score: ' .. score)
end

return game