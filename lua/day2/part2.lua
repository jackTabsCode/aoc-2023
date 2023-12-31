local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day2.txt")

function getGamePower(game: string): number
	local _, game = game:match("Game (.*):(.*)")

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

	return (highestCounts["red"] or 0) * (highestCounts["blue"] or 0) * (highestCounts["green"] or 0)
end

local games = input:split("\n")
local answer = 0
for _, game in pairs(games) do
	local power = getGamePower(game)
	answer = answer + power
end

print(answer)
