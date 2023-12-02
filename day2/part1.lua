local input = require("day2/input").input

local check = {
	["red"] = 12,
	["green"] = 13,
	["blue"] = 14,
}

function checkGame(game: string): { id: number, possible: boolean }
	local gameId = tonumber(game:match("Game (.*):"))
	local _, game = game:match("Game (.*):(.*)")

	local possible = true

	for _, round in pairs(game:split("; ")) do
		for _, pick in pairs(round:split(", ")) do
			local color = pick:match("%a+")
			local number = tonumber(pick:match("%d+"))

			if number > check[color] then
				possible = false
			end
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
