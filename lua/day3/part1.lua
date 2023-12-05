local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day3.txt")

local lines = input:split("\n")

local numbers = {}

for i, line in pairs(lines) do
	local pos = 1
	while true do
		local starts, ends = line:find("%d+", pos)
		if starts then
			local number = line:sub(starts, ends)
			table.insert(numbers, { position = starts, number = number, lineIndex = i })
			pos = ends + 1
		else
			break
		end
	end
end

function isSymbol(char: string)
	return char:find("[*#+$&=/%%@-]") ~= nil
end

function scanLine(line: string, pos: number, len: number)
	local sub = line:sub(pos - 1, pos + len)
	return isSymbol(sub)
end

local answer = 0

for _, number in pairs(numbers) do -- God bless our souls
	local found = false

	local lineIndex = number.lineIndex
	local pos = number.position
	local len = number.number:len()

	local lineAbove = lines[number.lineIndex - 1]
	if lineAbove then
		if scanLine(lineAbove, pos, len) then
			found = true
		end
	end

	local lineBelow = lines[number.lineIndex + 1]
	if lineBelow then
		if scanLine(lineBelow, pos, len) then
			found = true
		end
	end

	local currLine = lines[lineIndex]
	if scanLine(currLine, pos, len) then
		found = true
	end

	if found then
		answer = answer + number.number
	end
end

print(answer)
