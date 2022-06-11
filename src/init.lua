-- All game constan are privated
local musicVolume, sfxVolume, scaleX, scaleY

-- Initialize the constants
function initializeConfiguration()

    local Realww, Realwh, fullScreen, vSync

    local ConfSetings = {}
    -- Check if a configuration file exist
    if love.filesystem.getInfo('ConfSetings.lua') then
        -- if it exist load the options
        ConfSetings = love.filesystem.load('ConfSetings.lua')
        ConfSetings = ConfSetings()
    end

    -- Load video configuration
    Realww, Realwh = ConfSetings.windowsWidth or 800, ConfSetings.windowsHeight or 600
    fullScreen = ConfSetings.fullScreen or false
    vSync = ConfSetings.vsync or true

    -- Load Volumen configuration
    musicVolume = ConfSetings.musicVolume or 1
    sfxVolume = ConfSetings.sfxVolume or 1

    -- Aplly the video configuration options
    love.window.setMode(Realww, Realwh, { fullscreen = fullScreen, vsync = vSync })

    -- Get the scale
    scaleX = Realww / 800
    scaleY = Realwh / 600

end

-- Save the configuration
function saveConfiguration()

    local ww, wh, options = love.window.getMode()

    -- Create a table whit the configurations options and write to the configuration file
    local data = 'return {\n'
    data = data .. 'windowsWidth = ' .. ww .. ',\n'
    data = data .. 'windowsHeight = ' .. wh .. ',\n'
    data = data .. 'fullScreen = ' .. tostring(options.fullscreen) .. ',\n'
    data = data .. 'vsync = ' .. tostring(options.vsync) .. ',\n'
    data = data .. 'musicVolume = ' .. musicVolume .. ',\n'
    data = data .. 'sfxVolume = ' .. sfxVolume .. '\n'
    data = data .. '}\n'

    -- Save the data in a file
    love.filesystem.write('ConfSetings.lua', data)

end

function resizeWindows(newWW, newWH, newOptions)

    newOptions = newOptions or {}
    love.window.setMode(newWW, newWH, newOptions)
    newWW, newWH = love.window.getMode()
    scaleX = newWW / 800
    scaleY = newWH / 600

end

function debugStatics()
    local stats = love.graphics.getStats()
    print('----------------------------')
    print(stats.drawcalls .. '   drawcalls')
    print(stats.canvasswitches .. '   canvasswitches')
    print(stats.texturememory / 1024 / 1024 .. ' MB   texturememory')
    print(stats.images .. '    images')
    print(stats.canvases .. '    canvases')
    print(stats.fonts .. '    fonts')
    print(collectgarbage('count') / 1024 .. ' MB   memory')
    print(love.timer.getFPS() .. '     FPS')
    print('----------------------------')
end

function getWw()
    return 800
end

function getWh()
    return 600
end

function getWindowsMode()
    return love.window.getMode()
end

function getMusicVolume()
    return musicVolume
end

function setMusicVolume(num)
    if num >= 0 and num <= 1 then
        musicVolume = num
        return 0
    end
    return 1
end

function getSfxVolume()
    return sfxVolume
end

function setSfxVolume(num)
    if (num >= 0) and (num <= 1) then
        sfxVolume = num
        return 0
    end
    return 1
end

function getScaleX()
    return scaleX
end

function getScaleY()
    return scaleY
end
