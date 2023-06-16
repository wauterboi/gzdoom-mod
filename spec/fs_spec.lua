local fs = require 'fs'
local path = require 'pl.path'

describe('fs', function()
	describe('read_text_file', function()
		it('reads existing files', function()
			local res
			res = {fs.read_text_file(path.join('spec', 'fs_spec_text.txt'))}
			assert.are_equal(res[1], '1\n\t2\n\t\t3')
			assert.is_nil(res[2])
			res = {fs.read_text_file('a nonexistent file')}
			assert.is_nil(res[1])
			assert.matches('bad file `a nonexistent file`: .*', res[2])
		end)
	end)
end)
