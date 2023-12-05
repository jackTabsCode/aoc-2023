local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day4.txt")

function splitIntoNumbers(numbers: string)
	local result = {}
	for str in numbers:gmatch("([^ ]+)") do
		table.insert(result, tonumber(str))
	end
	return result
end

local lines = input:split("\n")

local cards = 0

function card(line: string) -- this took so long to run that I was working on a new solution by the time it finished
	cards += 1

	local cardNumber, winningNumbersText, myNumbersText = line:match("Card (.*): (.*) | (.*)")
	local winningNumbers, myNumbers = splitIntoNumbers(winningNumbersText), splitIntoNumbers(myNumbersText)

	local points = 0

	for _, number in winningNumbers do
		if table.find(myNumbers, number) then
			points += 1
		end
	end

	for i, nextLine in lines do
		if points > 0 and i > tonumber(cardNumber) then
			points -= 1
			card(nextLine)
		end
	end
end

for _, line in lines do
	card(line)
end

print(cards)
