--------------------------------------------------------------------------------
---Simplified functions for interacting with the filesystem
local fs = {}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---@alias YAMLExplicitScalar {[string]: function}
---@alias YAMLLoaderOpts {all: boolean, explicit_scalar: YAMLExplicitScalar, implicit_scalar: function}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Load a YAML stream into a Lua table.
---@type fun(stream: string, options: YAMLLoaderOpts?): table?
--------------------------------------------------------------------------------
local load_yaml = require 'lyaml' .load

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
local read_text_file = function(filepath)
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
fs.read_text_file = read_text_file
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---Read a YAML file as a table
---@param filepath string filesystem path to file
---@return table? # object equivalent to YAML representation or `nil` when unsuccessful
---@return string? # error message when unsuccessful
local read_yaml_file = function(filepath)
	local content
	do
		local err
		content, err = read_text_file(filepath)
		if content == nil then return nil, err end
	end
	local result = {pcall(load_yaml, content)}
	if result[1] == false then return nil, result[2] end
	if result[2] == nil then return nil, result[3] end
	return result[2]
end
fs.read_yaml_file = read_yaml_file
--------------------------------------------------------------------------------

return fs
