--------------------------------------------------------------------------------
local log = require 'log'
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---@as table<LogColorName, LogColorANSI>
local color	= require 'ansikit.palette' .color4
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---@as string
local reset = require 'ansikit.text' .reset
--------------------------------------------------------------------------------

describe('log', function()
	describe('add', function()
		it('writes formatted text with timestamps and ANSI color codes', function()
			for name, style in pairs(log.status) do
				assert.are.equal(
					log.add(name, 'This is a test'),
					table.concat({
						'[',
						os.date(),
						'] [',
						style.color,
						style.text,
						reset,
						']: ',
						'This is a test'
					})
				)
			end
		end)
	end)
end)