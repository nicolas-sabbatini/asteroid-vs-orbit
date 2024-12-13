--[[
tape.lua v1.0.0

The MIT License (MIT)

Copyright (c) 2024 Nicolás Sabbatini

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

local logFile = "log.log"
local logLevel = 3
local logOutput = "all"

local lables = {}

---@enum (key) Tape.Level
local LogLevel = {
	error = 1,
	warn = 2,
	debug = 3,
}

---@enum (key) Tape.Output
local LogOutput = {
	all = function(message)
		print(message)
		love.filesystem.append(logFile, message)
	end,
	file = function(message)
		love.filesystem.append(logFile, message)
	end,
	console = function(message)
		print(message)
	end,
}

local colors = {
	error = "\27[31;1m",
	warn = "\27[33;1m",
	debug = "\27[34;1m",
}

Tape = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/lovely-tools",
	_VERSION = "v1.0.0",
}

---Receives any number of arguments and records them in the output
---@param ... any
function Tape.record(...)
	local logMessage = ""
	for _, v in ipairs({ ... }) do
		logMessage = logMessage .. tostring(v) .. "\t"
	end
	logMessage = logMessage .. "\n"
	LogOutput[logOutput](logMessage)
end

---Creates a new log file and set up variables
---@param output Tape.Output | nil where to record the logs (Default `all`)
---@param path string | nil If you wish to save logs to file you mus provide a file name (This file is inside the game's save directory, default `log.log`)
---@param level Tape.Level | nil Minimum log level to be recorder (Default `debug`)
---@param mode "full"|"line"|"no"|nil Sets the buffering mode for an output file (Help `io.stdout:setvbuf`, Default `no`)
function Tape.init(output, path, level, mode)
	logOutput = output or "all"
	logFile = path or "log.log"
	logLevel = LogLevel[level] or LogLevel.debug
	io.stdout:setvbuf(mode or "no")
	if logOutput ~= "console" then
		local pathOfFileDir = love.filesystem.getRealDirectory(logFile)
		local pathOfSaveDir = love.filesystem.getSaveDirectory()
		local exist = pathOfFileDir ~= nil and pathOfFileDir == pathOfSaveDir
		if not exist then
			love.filesystem.newFile(logFile)
		end
	end
end

---Records a new log entry
---@param level Tape.Level Level of the log
---@param message string Format string that follows the same rules as the ISO C function sprintf
---@param ... any values to format the string
function Tape.log(level, message, ...)
	if logLevel < LogLevel[level] then
		return
	end
	local header = string.format("%s[%s - %s]\27[0m ", colors[level], level, os.date("%H:%M:%S"))
	local formatMessage = string.format(message, ...)
	Tape.record(header, formatMessage)
end

---An assert function that saves the negative output to the log file
---@param condition boolean Result of a test condition if the condition is false halt the program
---@param message string Error message
function Tape.assert(condition, message)
	if not condition then
		local logMessage = string.format(
			"\27[41;1m[Assert - %s]\27[0m %s\r\n",
			os.date("%H:%M:%S"),
			debug.traceback(tostring(message))
		)
		Tape.record(logMessage)
		error(message)
	end
end

---Clears the log file, if the chosen output is `console` it does noting
function Tape.clear()
	if logOutput == "console" then
		return
	end
	local res = love.filesystem.remove(logFile)
	if res then
		love.filesystem.newFile(logFile)
		Tape.log("debug", "save file deleted")
	end
end

---Records the number of times this line has been called with the given label
---```
---If you call the count function with a level that is nil or grater to the
---current 'logLevel' the label is going to count but is not going to show in the logs
---```
---@param label string The label to keep track
---@param level Tape.Level|nil Level of the log
function Tape.count(label, level)
	if not lables[label] then
		lables[label] = 0
	end
	lables[label] = lables[label] + 1
	if level then
		local logMessage = string.format("[Count]  %s %s", label, tostring(lables[label]))
		Tape.log(level, logMessage)
	end
end

local function tableToString(var, tab, pTab)
	if type(var) == "table" then
		local base = "{\n\r"
		for k, v in pairs(var) do
			base = base .. tab .. k .. " = " .. tableToString(v, tab .. "\t", tab) .. ",\n\r"
		end
		return base .. pTab .. "}"
	end
	return tostring(var)
end

---Logs a table in a human-readable way
---```
---Warning! If you attempt to log a recursive table this function is going to crash
---```
---@param level Tape.Level The level of the log
---@param table table The table to log (`Warning! If you attempt to log a recursive table this function is going to crash`)
function Tape.table(level, table)
	Tape.log(level, tableToString(table, "\t", ""))
end
