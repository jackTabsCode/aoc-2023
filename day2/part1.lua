local input = require("day2/input").input

local check = {
	["red"] = 12,
	["green"] = 13,
	["blue"] = 14,
}

function checkGame(game: string): { id: number, possible: boolean }
	local gameId = tonumber(game:match("Game (.*):"))
	local _, gameEnd = game:find("Game (.*):")
	game = game:sub(gameEnd + 2) -- not sure why I couldn't just put spaces in the game pattern

	local highestCounts = {}

	for _, round in pairs(game:split("; ")) do
		for _, pick in pairs(round:split(", ")) do
			local color = pick:match("%a+")
			local number = tonumber(pick:match("%d+"))

			local found = highestCounts[color]
			if not found or number > found then
				highestCounts[color] = number
			end
		end
	end

	local possible = true
	for color, number in pairs(highestCounts) do
		if number > check[color] then
			possible = false
		end
	end

	return { id = gameId, possible = possible }
end

local games = input:split("\n")
local answer = 0
for _, game in pairs(games) do
	local result = checkGame(game)
	if result.possible then
		answer = answer + result.id
	end
end

print(answer)
