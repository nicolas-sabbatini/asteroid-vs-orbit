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

local RGB = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/lovely-tools",
	_VERSION = "v0.1.0",
}

if not bit then
	local function memoize(f)
		local mt = {}
		local t = setmetatable({}, mt)
		function mt:__index(k)
			local v = f(k)
			t[k] = v
			return v
		end

		return t
	end

	local function make_bitop_uncached(t, m)
		local function bitop(a, b)
			local res, p = 0, 1
			while a ~= 0 and b ~= 0 do
				local am, bm = a % m, b % m
				res = res + t[am][bm] * p
				a = (a - am) / m
				b = (b - bm) / m
				p = p * m
			end
			res = res + (a + b) * p
			return res
		end
		return bitop
	end

	local function make_bitop(t)
		local op1 = make_bitop_uncached(t, 2 ^ 1)
		local op2 = memoize(function(a)
			return memoize(function(b)
				return op1(a, b)
			end)
		end)
		return make_bitop_uncached(op2, 2 ^ (t.n or 1))
	end

	local bxor = make_bitop({ [0] = { [0] = 0, [1] = 1 }, [1] = { [0] = 1, [1] = 0 }, n = 4 })

	local function band(a, b)
		return ((a + b) - bxor(a, b)) / 2
	end

	local function rshift(a, disp)
		return math.floor(a % 2 ^ 32 / 2 ^ disp)
	end

	bit = {
		band = band,
		rshift = rshift,
	}
end

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
