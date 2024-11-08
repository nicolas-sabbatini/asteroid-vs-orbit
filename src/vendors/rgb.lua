--[[
rgb.lua v0.1.0

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

local RGB = {}

---Transform a number in `0xRRGGBB` format to a table RGB with values between 0..1
---@param num number must be in `0xRRGGBB` format
---@return table RGB on format `{1: number, 2: number, 3: number}` each number on value between 0..1
function RGB.exaToTable(num)
	local r = bit.band(bit.rshift(num, 16), 0xFF) / 0xFF
	local g = bit.band(bit.rshift(num, 8), 0xFF) / 0xFF
	local b = bit.band(num, 0xFF) / 0xFF
	return { r, g, b }
end

---Transform a number in `0xRRGGBBAA` format to a table RGBA with values between 0..1
---@param num number must be in `0xRRGGBBAA` format
---@return table RGBA on format `{1: number, 2: number, 3: number, 4: number}` each number on value between 0..1
function RGB.alphaExaToTable(num)
	local r = bit.band(bit.rshift(num, 24), 0xFF) / 0xFF
	local g = bit.band(bit.rshift(num, 16), 0xFF) / 0xFF
	local b = bit.band(bit.rshift(num, 8), 0xFF) / 0xFF
	local a = bit.band(num, 0xFF) / 0xFF
	return { r, g, b, a }
end

return RGB
