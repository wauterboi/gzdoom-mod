--------------------------------------------------------------------------------
---Module for logging ANSI formatted text using `io.write`
local log = {}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Valid color names
---@alias LogColorName
---| 'black'
---| 'red'
---| 'green'
---| 'yellow'
---| 'blue'
---| 'magenta'
---| 'cyan'
---| 'white'
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---A simple alias to specify that the string returned is an ANSI formatting
---escape sequence
---@alias LogColorANSI string
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Valid message status values
---@alias LogStatusType
---| 'okay'
---| 'info'
---| 'warn'
---| 'fail'
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---ANSI color escape sequence and display text
---@alias LogStatusStyle {color: LogColorANSI, text: string}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---All available 4-bit ANSI color formatting escape sequences
---@as table<LogColorName, LogColorANSI>
local color	= require 'ansikit.palette' .color4
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Escape sequence for resetting formatting to defaults
---@as string
local reset = require 'ansikit.text' .reset
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---All available status color ANSI escape sequences and display text
---@type table<LogStatusType, LogStatusStyle>
log.status = {
	okay = {
		color = color.green
	},
	info = {
		color = color.blue
	},
	warn = {
		color = color.yellow
	},
	fail = {
		color = color.red
	}
}

for key, value in pairs(log.status) do
	value.text = key
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Log a timestampped message of a certain status using `io.write`
---@param status LogStatusType The status the message is reoprting
---@param ... string Anything to append to the message
---@return string # The formatted string (without supplementled new line)
log.add = function(status, ...)
	local buffer = {}
	local index = 7

	local style = log.status[status]
	buffer[1] = '['
	buffer[2] = os.date()
	buffer[3] = '] ['
	buffer[4] = style.color
	buffer[5] = style.text
	buffer[6] = reset
	buffer[7] = ']: '

	for param, value in ipairs {...} do
		index = index + 1
		buffer[index] =
			value ~= nil and tostring(value) or
			string.format('(nil argument #%i)', param)
	end

	local result = table.concat(buffer)
	io.write(result, '\n')
	return result
end
--------------------------------------------------------------------------------

return log