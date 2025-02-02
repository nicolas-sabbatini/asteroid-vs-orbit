local save_file = "save.lua"

if love.system.getOS() == "Web" then
	Tape.log("debug", "runing on Web")

	return function()
		Tape.log("debug", "Can't save on Web")
	end
end

local function interpolate_score(score)
	return string.format("return { HIGH_SCORE = %d }", score)
end

local path_of_file_dir = love.filesystem.getRealDirectory(save_file)
local path_of_save_dir = love.filesystem.getSaveDirectory()
local exist = path_of_file_dir ~= nil and path_of_file_dir == path_of_save_dir
if not exist then
	Tape.log("debug", "File created: %s/%s", path_of_save_dir, save_file)
	local success, message = love.filesystem.write(save_file, interpolate_score(HIGH_SCORE))
	if not success then
		Tape.log("error", message)
	end
end

local chunk, error = love.filesystem.load(save_file)
if error then
	Tape.log("error", error)
	chunk = function()
		return { HIGH_SCORE = 0 }
	end
end
local save = chunk()

HIGH_SCORE = save.HIGH_SCORE
Tape.log("debug", "Loaded high score = %d", HIGH_SCORE)

return function()
	Tape.log("debug", "Save file: %s/%s", path_of_save_dir, save_file)
	local success, message = love.filesystem.write(save_file, interpolate_score(HIGH_SCORE))
	if not success then
		Tape.log("error", message)
	end
end
