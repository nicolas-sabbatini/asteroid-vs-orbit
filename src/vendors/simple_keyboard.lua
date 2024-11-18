---@class SimpleKeyboard
---@field private keysPressed any
---@field private keysJustPressed any
---@field private keysJustReleased any
local SimpleKeyboard = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/lovely-tools",
	_VERSION = "v3.0.2",
	keysPressed = {},
	keysJustPressed = {},
	keysJustReleased = {},
}

---Create a new instance of simple keyboard.
---@param keys  love.KeyConstant | love.KeyConstant[]
---@return SimpleKeyboard - An instance of SimpleKeyboard
function SimpleKeyboard.createInstance(keys)
	local instance = setmetatable({
		keysPressed = {},
		keysJustPressed = {},
		keysJustReleased = {},
	}, { __index = SimpleKeyboard })
	instance:keyBind(keys)
	return instance
end

---Bind a key or a table of keys to the instance.
---@param keys  love.KeyConstant | love.KeyConstant[]
function SimpleKeyboard:keyBind(keys)
	if not keys then
		return
	elseif type(keys) ~= "table" then
		keys = { keys }
	end
	for _, k in pairs(keys) do
		self.keysPressed[k] = false
		self.keysJustReleased[k] = false
		self.keysJustPressed[k] = false
	end
end

---Unbind a key or a table of keys in the instance.
---@param keys  love.KeyConstant | love.KeyConstant[]
function SimpleKeyboard:keyUnbind(keys)
	if not keys then
		return
	elseif type(keys) ~= "table" then
		keys = { keys }
	end
	for _, k in pairs(keys) do
		self.keysPressed[k] = nil
		self.keysJustReleased[k] = nil
		self.keysJustPressed[k] = nil
	end
end

---Update the state of all bound keys.
function SimpleKeyboard:updateInput()
	for k, previus in pairs(self.keysPressed) do
		self.keysPressed[k] = love.keyboard.isDown(k)
		self.keysJustReleased[k] = previus and not self.keysPressed[k]
		self.keysJustPressed[k] = (not previus) and self.keysPressed[k]
	end
end

---Return true if is the first frame the bound key is down.
---@param key love.KeyConstant
---@return boolean — True if the key is down, false if not.
function SimpleKeyboard:justPressed(key)
	return self.keysJustPressed[key]
end

---Return true if a bound key is down.
---@param key love.KeyConstant
---@return boolean — True if the key is down, false if not.
function SimpleKeyboard:isDown(key)
	return self.keysPressed[key]
end

---Return true if is the first frame the bound key is released.
---@param key love.KeyConstant
---@return boolean — True if the key is released, false if not.
function SimpleKeyboard:justReleased(key)
	return self.keysJustReleased[key]
end

return SimpleKeyboard
