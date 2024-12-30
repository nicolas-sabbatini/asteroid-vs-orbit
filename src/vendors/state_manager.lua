--[[
state_manager.lua v0.2.0

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

local function empty() end

---@class love.State
---@field update fun(dt)? Update function called when the state is running
---@field draw fun()? Draw function called when the state is running
---@field enter fun(...)? Function called when the state enters on the stack
---@field exit fun()? Function called when the state exit the stack
---@field pausedUpdate fun(dt)? Update function called when the state is paused
---@field pausedDraw fun()? Draw function called when the state is paused

---@type love.State[]
local executingStates = {}
---@type love.State[]
local posibleStates = {}
---@type number
local currentState = 0

love.states = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/lovely-tools",
	_VERSION = "v0.2.0",
}

---Adds a new state in the state manager
---@param stateName string
---@param state love.State
function love.states.addState(stateName, state)
	posibleStates[stateName] = {
		update = state.update or empty,
		draw = state.draw or empty,
		enter = state.enter or empty,
		exit = state.exit or empty,
		pausedUpdate = state.pausedUpdate or empty,
		pausedDraw = state.pausedDraw or empty,
	}
end

---Push the specified state into the stack and pauses the
---previews running state, this function is not
---going to have any effect until the start of the next frame.
---You can also use `love.event.push("pushState", newState, ...)`
---to have the same effect
---@param newState string
---@param ... unknown
function love.states.pushState(newState, ...)
	love.event.push("pushState", newState, ...)
end

---Removes the selected amount of states from the stack, this
---function is not going to have any effect until the start
---of the next frame.
---You can also use `love.event.push("popState", amount)`
---to have the same effect
function love.states.popState(amount)
	love.event.push("popState", amount)
end

---Changes the current running state for the specified state,
---function is not going to have any effect until the start
---of the next frame.
---You can also use `love.event.push("swichState", newState, ...)`
---to have the same effect
---@param newState string
---@param ... unknown
function love.states.swichState(newState, ...)
	love.event.push("swichState", newState, ...)
end

---Gets the amount of states currently on the stack
---@return integer
function love.states.getStackSize()
	return #executingStates
end

function love.handlers.pushState(stateName, ...)
	assert(stateName, "You must pass a name to the function")
	assert(posibleStates[stateName], "The state '" .. stateName .. "' do not exist")
	table.insert(executingStates, posibleStates[stateName])
	currentState = #executingStates
	executingStates[currentState].enter(...)
end

function love.handlers.popState(amount)
	local til = math.max(currentState - amount, 0)
	for i = currentState, 0, -1 do
		local exitState = table.remove(executingStates, i)
		exitState.exit()
		if i == til then
			break
		end
	end
end

function love.handlers.swichState(stateName, ...)
	assert(posibleStates[stateName], "The state " .. stateName .. " do not exist")
	local exitState = table.remove(executingStates, currentState)
	if exitState then
		exitState.exit()
	end
	table.insert(executingStates, posibleStates[stateName])
	currentState = #executingStates
	executingStates[currentState].enter(...)
end

function love.run()
	-- Check requirements
	assert(love.graphics, "love.graphics is required to use this module")
	assert(love.event, "love.event is required to use this module")
	assert(love.timer, "love.timer is required to use this module")
	-- Set up optional requirements
	if not love.update then
		love.update = empty
	end
	if not love.draw then
		love.draw = empty
	end
	if not love.quit then
		love.quit = empty
	end
	-- Load user defined stuff
	if love.load then
		love.load(love.arg.parseGameArguments(arg), arg)
	end
	-- Clear timer
	local dt = 0
	love.timer.step()
	-- Main loop
	return function()
		-- Handle events
		love.event.pump()
		for name, a, b, c, d, e, f in love.event.poll() do
			if name == "quit" then
				if not love.quit() then
					return a or 0
				end
			end
			love.handlers[name](a, b, c, d, e, f)
		end
		-- Update
		dt = love.timer.step()
		love.update(dt)
		-- Execute states
		if currentState > 0 then
			for i = 1, currentState - 1 do
				executingStates[i].pausedUpdate(dt)
			end
			executingStates[currentState].update(dt)
		end
		-- Draw
		love.graphics.origin()
		love.graphics.clear(love.graphics.getBackgroundColor())
		-- Draw states
		if currentState > 0 then
			for i = 1, currentState - 1 do
				executingStates[i].pausedDraw()
			end
			executingStates[currentState].draw()
		end
		-- Draw to the screen
		love.draw()
		love.graphics.present()
		-- Request next fame
		love.timer.sleep(0.001)
	end
end
