local input = require("day2/input").input

function getGamePower(game: string)
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

	return (highestCounts["red"] or 0) * (highestCounts["blue"] or 0) * (highestCounts["green"] or 0)
end

local games = input:split("\n")
local answer = 0
for _, game in pairs(games) do
	local power = getGamePower(game)
	answer = answer + power
end

print(answer)
