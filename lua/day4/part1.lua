local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day4.txt")

function splitIntoNumbers(numbers: string)
	local result = {}
	for str in numbers:gmatch("([^ ]+)") do
		table.insert(result, tonumber(str))
	end
	return result
end

function card(line: string): number
	local _, winningNumbersText, myNumbersText = line:match("Card (.*): (.*) | (.*)")
	local winningNumbers, myNumbers = splitIntoNumbers(winningNumbersText), splitIntoNumbers(myNumbersText)

	local points = 0

	for _, number in winningNumbers do
		if table.find(myNumbers, number) then
			if points == 0 then
				points = 1
			else
				points *= 2
			end
		end
	end

	return points
end

local total = 0

for _, line in input:split("\n") do
	total += card(line)
end

print(total)
