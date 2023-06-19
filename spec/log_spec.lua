local log = require 'lib.log'

local reset = require 'ansikit.text' .reset

describe('log', function()
	describe('add', function()
		it('writes formatted text with timestamps and ANSI color codes', function()
			local prev = io.output()
			io.output('/dev/null')
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
				io.close()
				io.open(prev)
			end
		end)
	end)
end)
