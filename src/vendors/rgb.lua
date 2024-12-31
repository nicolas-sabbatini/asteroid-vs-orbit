--[[
rgb.lua v0.2.0

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

local RGB = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/lovely-tools",
	_VERSION = "v0.2.0",
}

---Transform a number in `0xRRGGBB` format to a table RGB with values between 0..1
---@param num number must be in `0xRRGGBB` format
---@return table RGB on format `{1: number, 2: number, 3: number}` each number on value between 0..1
function RGB.exaToTable(num)
	local num = string.format("%X", num)
	local r = tonumber(string.sub(num, 1, 2), 16) / 0xFF
	local g = tonumber(string.sub(num, 3, 4), 16) / 0xFF
	local b = tonumber(string.sub(num, 5, 6), 16) / 0xFF
	return { r, g, b }
end

---Transform a number in `0xRRGGBBAA` format to a table RGBA with values between 0..1
---@param num number must be in `0xRRGGBBAA` format
---@return table RGBA on format `{1: number, 2: number, 3: number, 4: number}` each number on value between 0..1
function RGB.alphaExaToTable(num)
	local num = string.format("%X", num)
	local r = tonumber(string.sub(num, 1, 2), 16) / 0xFF
	local g = tonumber(string.sub(num, 3, 4), 16) / 0xFF
	local b = tonumber(string.sub(num, 5, 6), 16) / 0xFF
	local a = tonumber(string.sub(num, 7, 8), 16) / 0xFF
	return { r, g, b, a }
end

return RGB
