--------------------------------------------------------------------------------
---Simplified functions for interacting with the filesystem
local fs = {}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Return a formatted error for the `fs.read_text_file` function
---@param filepath string filesystem path to file
---@param err string? error message
---@return string # formatted error message
local function read_text_file_error(filepath, err)
	return string.format(
		'bad file `%s`: %s',
		tostring(filepath) or 'nil',
		tostring(err) or 'nil'
	)
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Read a text file as a string
---@param filepath string filesystem path to file
---@return string? # file contents as string or `nil` when unsuccessful
---@return string? # error message when unsuccessful
fs.read_text_file = function(filepath)
	local file
	do
		local err
		file, err = io.open(filepath, 'r')
		if file == nil then
			return nil, read_text_file_error(filepath, err)
		end
	end

	---file cannot be nil here
	---@cast file -nil

	local content = file:read('*a')
	if content == nil then
		return nil, read_text_file_error(filepath, 'unable to read or empty')
	end

	return content
end
--------------------------------------------------------------------------------

return fs
