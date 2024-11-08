--[[
letterbox.lua v0.1.0

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

-- Utils
local function uuid()
	return string.gsub("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx", "[xy]", function(c)
		local v = (c == "x") and love.math.random(0, 0xf) or love.math.random(8, 0xb)
		return string.format("%x", v)
	end)
end
--

---@class letterbox.Rectangle
---@field width number
---@field height number

---@class letterbox.Upscale.Normal: letterbox.Rectangle
---@field type 'normal'

---@class letterbox.Upscale.PixelPerfect: letterbox.Rectangle
---@field type 'pixel-perfect'

---@class letterbox.Upscale.Constant
---@field type 'constant'
---@field x number
---@field y number

---@class letterbox.Rig
---@field package size letterbox.Rectangle
---@field package childerns letterbox.Rig[]
---@field package renderTarget love.Canvas
---@field package offset {x: number, y: number}
---@field package scale {x: number, y: number}
---@field name string
---@field draw fun(self: letterbox.Rig) draws the current and child rigs on the screen
---@field drawInsideRig fun(self: letterbox.Rig) start drawing inside the rig, the next draw call will modify the internal canvas of the rig (after all wanted changes you mus call `stopDrawInsideRig`)
---@field stopDrawInsideRig fun(self: letterbox.Rig) stop drawing inside the rig, this function is expected to be call after `drawInsideRig`
---@field addChildren fun(self: letterbox.Rig, children: letterbox.Rig) adds a children to the rig
---@field removeChildren fun(self: letterbox.Rig, childrenName: string) removes the target children, if the children do not exist does nothing

---@param self letterbox.Rig
local function draw(self)
	love.graphics.push()
	love.graphics.translate(self.offset.x, self.offset.y)
	love.graphics.scale(self.scale.x, self.scale.y)
	love.graphics.draw(self.renderTarget)
	for _, child in ipairs(self.childerns) do
		child:draw()
	end
	love.graphics.pop()
end

---@param self letterbox.Rig
local function drawInsideRig(self)
	love.graphics.push()
	love.graphics.setCanvas(self.renderTarget)
end

local function stopDrawInsideRig(_)
	love.graphics.pop()
	love.graphics.setCanvas()
end

---@param self letterbox.Rig
---@param child letterbox.Rig
local function addChildren(self, child)
	table.insert(self.childerns, child)
end

---@param self letterbox.Rig
---@param childrenName string
local function removeChildren(self, childrenName)
	local target = nil
	for k, v in pairs(self.childerns) do
		if v.name == childrenName then
			target = k
			break
		end
	end
	if target then
		table.remove(self.childerns, target)
	end
end

---@class letterbox.Rig.Normal: letterbox.Rig
---@field package upscale letterbox.Upscale.Normal
---@field resizeParent fun(self: letterbox.Rig.Normal, parent: letterbox.Rectangle) recalculates the rig variables to fit new parent
---@field reCalculateVaribles fun(self: letterbox.Rig.Normal) recalculates the rig variables to fit current parent

---@param self letterbox.Rig.Normal
---@param parent letterbox.Rectangle
local function normalResizeParent(self, parent)
	self.upscale.width = parent.width
	self.upscale.height = parent.height
	self:reCalculateVaribles()
end

---@param self letterbox.Rig.Normal
local function normalReCalculateVariables(self)
	local newScaleFactor = math.min(self.upscale.width / self.size.width, self.upscale.height / self.size.height)
	self.scale.x = newScaleFactor
	self.scale.y = newScaleFactor
	local new_width = self.size.width * newScaleFactor
	local new_height = self.size.height * newScaleFactor
	self.offset.x = (self.upscale.width - new_width) / 2
	self.offset.y = (self.upscale.height - new_height) / 2
end

---@class letterbox.Rig.PixelPerfect: letterbox.Rig
---@field package upscale letterbox.Upscale.PixelPerfect
---@field resizeParent fun(self: letterbox.Rig.PixelPerfect, parent: letterbox.Rectangle) recalculates the rig variables to fit new parent
---@field reCalculateVaribles fun(self: letterbox.Rig.PixelPerfect) recalculates the rig variables to fit current parent

---@param self letterbox.Rig.PixelPerfect
---@param parent letterbox.Rectangle
local function pixelPerfectResizeParent(self, parent)
	self.upscale.width = parent.width
	self.upscale.height = parent.height
	self:reCalculateVaribles()
end

---@param self letterbox.Rig.PixelPerfect
local function pixelPerfectReCalculateVariables(self)
	local newScaleFactor = math.min(self.upscale.width / self.size.width, self.upscale.height / self.size.height)
	if newScaleFactor > 1 then
		newScaleFactor = math.floor(newScaleFactor)
	end
	print(newScaleFactor)
	self.scale.x = newScaleFactor
	self.scale.y = newScaleFactor
	local new_width = self.size.width * newScaleFactor
	local new_height = self.size.height * newScaleFactor
	self.offset.x = (self.upscale.width - new_width) / 2
	self.offset.y = (self.upscale.height - new_height) / 2
end

---@class letterbox.Rig.Constant: letterbox.Rig
---@field package upscale letterbox.Upscale.Constant
---@field move fun(self: letterbox.Rig.Constant, x: number, y: number) move the top left corner off the rig to the new coordinates

---@param self letterbox.Rig.Constant
---@param x number
---@param y number
local function constantMove(self, x, y)
	self.upscale.x = x
	self.upscale.y = y
	self.offset.x = x
	self.offset.y = y
end

local Letterbox = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/lovely-tools",
	_VERSION = "v0.1.0",
}

---Creates a new camera rig
---@overload fun(upscale: letterbox.Upscale.Normal, size: letterbox.Rectangle, name?: string): letterbox.Rig.Normal
---@overload fun(upscale: letterbox.Upscale.PixelPerfect, size: letterbox.Rectangle, name?: string): letterbox.Rig.PixelPerfect
---@overload fun(upscale: letterbox.Upscale.Constant, size: letterbox.Rectangle, name?: string): letterbox.Rig.Constant
function Letterbox.newLetterbox(upscale, size, name)
	local newRig = {
		upscale = upscale,
		size = size,
		childerns = {},
		renderTarget = love.graphics.newCanvas(size.width, size.height),
		offset = { x = 0, y = 0 },
		scale = { x = 1, y = 1 },
		name = name or uuid(),
		draw = draw,
		drawInsideRig = drawInsideRig,
		stopDrawInsideRig = stopDrawInsideRig,
		addChildren = addChildren,
		removeChildren = removeChildren,
	}

	if upscale.type == "normal" then
		newRig.reCalculateVaribles = normalReCalculateVariables
		newRig.resizeParent = normalResizeParent
		newRig:reCalculateVaribles()
		return newRig --[[@as letterbox.Rig.Normal]]
	elseif upscale.type == "pixel-perfect" then
		newRig.reCalculateVaribles = pixelPerfectReCalculateVariables
		newRig.resizeParent = pixelPerfectResizeParent
		newRig:reCalculateVaribles()
		return newRig --[[@as letterbox.Rig.PixelPerfect]]
	elseif upscale.type == "constant" then
		newRig.offset.x = upscale.x
		newRig.offset.y = upscale.y
		newRig.move = constantMove
		return newRig --[[@as letterbox.Rig.Constant]]
	else
		error("Unknown letterbox rig upscale config")
	end
end

return Letterbox
