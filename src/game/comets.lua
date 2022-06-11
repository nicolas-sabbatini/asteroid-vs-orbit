local comets = {}

comets.c = {}
comets.max = 3
comets.time = 0

local particle = love.graphics.newImage('assets/pixel.png')
particle:setFilter('nearest', 'nearest')

function comets:restart()
    comets.c = {}
    comets.max = 3
    comets.time = 0
end

function comets:new(star)
    local c = {}
    local angle = math.deg(love.math.random(0, 360))
    c.sin = math.sin(angle)
    c.cos = math.cos(angle)
    c.d = 400
    c.x = star.x + c.sin * c.d
    c.y = star.y + c.cos * c.d
    c.v = love.math.random(80, 150)
    -- particle sistem
    c.ps = love.graphics.newParticleSystem(particle, 60)
    c.ps:setParticleLifetime(0.5, 1.5)
    c.ps:setEmissionRate(25)
    c.ps:setEmissionArea('ellipse', 10, 10)
    c.ps:setLinearAcceleration(c.v * c.sin, c.v * c.cos)
    --               r    g  b  a r1 g1 b1 a1
    c.ps:setColors(0.4, 0.3, 1, 1, 1, 1, 1, 0)
    c.ps:update(1)
    table.insert(comets.c, c)
end

function comets:update(dt, star, planet)
    comets.time = comets.time + dt
    if comets.time > comets.max then
        comets:new(star)
        if comets.max > 0.3 then
            comets.max = comets.max - (comets.max / 30)
        end
        comets.time = 0
    end
    for k, c in pairs(comets.c) do
        local pos = math.sqrt(((c.x - planet.x) ^ 2 + (c.y - planet.y) ^ 2))
        if pos < 17 then
            planet.alive = false
        end
        c.d = c.d - c.v * dt
        c.x = star.x + c.sin * c.d
        c.y = star.y + c.cos * c.d
        -- update particles
        c.ps:update(dt)
        -- If the element is remove the nex element is going to take
        -- its place, k-1 avoid skiping an element
        if c.d < 10 then
            c.ps:release()
            table.remove(comets.c, k);
            k = k - 1
        end
    end
end

function comets:draw()
    for _, c in pairs(comets.c) do
        love.graphics.setColor(0.4, 0.3, 1)
        love.graphics.circle('fill', c.x, c.y, 10)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(c.ps, c.x, c.y)
    end
end

return comets
