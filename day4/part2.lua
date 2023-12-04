local input = require("day4/input").input

local example = [[Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11]]

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

	print(`doing {cardNumber}`)

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
