local input = require("day3/input").input

local lines = input:split("\n")

local gears = {}

for i, line in pairs(lines) do
	local pos = 1
	while true do
		local starts, ends = line:find("*", pos)
		if starts then
			table.insert(gears, { pos = starts, lineIndex = i })
			pos = ends + 1
		else
			break
		end
	end
end

function scanLine(line: string, gearPos: number)
	local numbers = {}

	local pos = 1
	while true do
		local starts, ends = line:find("%d+", pos)
		if starts then
			if gearPos + 1 >= starts and gearPos - 1 <= ends then
				local number = tonumber(line:sub(starts, ends))
				table.insert(numbers, number)
			end
			pos = ends + 1
		else
			break
		end
	end

	return numbers
end

local answer = 0

for _, gear in pairs(gears) do -- Noooo
	local matches = {}

	for i = gear.lineIndex - 1, gear.lineIndex + 1 do
		local result = scanLine(lines[i], gear.pos)
		for _, number in pairs(result) do
			table.insert(matches, number)
		end
	end

	if #matches == 2 then
		answer += (matches[1] * matches[2])
	end
end

print(answer)
