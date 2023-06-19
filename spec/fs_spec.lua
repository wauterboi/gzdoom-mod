local fs = require 'lib.fs'
local path = require 'pl.path'

describe('fs', function()
	describe('read_text_file', function()
		it('reads existing files', function()
			local result, err

			result, err = fs.read_text_file(path.join('spec', 'fs_spec_text.txt'))
			assert.are_equal(result, '1\n\t2\n\t\t3')
			assert.is_nil(err)

			result, err = fs.read_text_file('a nonexistent file')
			assert.is_nil(result)
			assert.matches('bad file `a nonexistent file`: .*', err)
		end)
	end)

	describe('read_yaml_file', function()
		it('converts YAML markup into Lua table equivalents', function()
			local result, err

			result, err = fs.read_yaml_file(path.join('spec', 'fs_spec_yaml.yaml'))
			assert.are_same(result, {
				{
					name = "Casiopea 1st",
					from = 1976,
					to = 1989
				},
				{
					name = "Casiopea 2nd",
					from = 1990,
					to = 2006
				},
				{
					name = "Casiopea 3rd",
					from = 2012,
					to = 2022
				},
				{
					name = "Casiopea-P4",
					from = 2022
				}
			})
			assert.is_nil(err)

			result, err = fs.read_yaml_file('a nonexistent file')
			assert.is_nil(result)
			assert.is_not_nil(err)
		end)
	end)
end)
