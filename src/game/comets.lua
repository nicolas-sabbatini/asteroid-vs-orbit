local comets = {}

comets.c = {}
comets.max = 3
comets.time = 0

function comets:restart()
    comets.c = {}
    comets.max = 3
    comets.time = 0
end

function comets:new(star)
    local c = {}
    local angle = math.deg(math.random(0, 360))
    c.sin =math.sin(angle)
    c.cos =math.cos(angle)
    c.d = 400
    c.x = star.x + c.sin * c.d
    c.y = star.y + c.cos * c.d        
    c.v = math.random(80, 150)
    table.insert(comets.c, c)
    print(#comets.c)
end

function comets:update(dt, star, planet)
    comets.time = comets.time + dt
    if comets.time > comets.max then
        comets:new(star)
        if comets.max > 0.3 then
            comets.max = comets.max - (0.3/comets.max)
            print(comets.max)
        end
        comets.time = 0
    end
    for k, c in pairs(comets.c) do
        local pos = math.sqrt(((c.x-planet.x)^2 + (c.y-planet.y)^2))
        if pos < 17 then
            print('comet', pos)
            gamefriz()
        end
        c.d = c.d - c.v*dt
        c.x = star.x + c.sin * c.d
        c.y = star.y + c.cos * c.d
        -- If the element is remove the nex element is going to take
        -- its place, k-1 avoid skiping an element
        if c.d < 10 then table.remove(comets.c, k); k = k-1 end
        print(#comets.c)
    end
end

function comets:draw()
    for _, c in pairs(comets.c) do
        love.graphics.circle('fill', c.x, c.y, 10)
    end
end

return comets