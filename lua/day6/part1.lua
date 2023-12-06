local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day6.txt")

local lines = input:split("\n")

local times = {}
for time in lines[1]:gmatch("%d+") do
	table.insert(times, tonumber(time))
end

local distances = {}
for distance in lines[2]:gmatch("%d+") do
	table.insert(distances, tonumber(distance))
end

local lastWin = 1

for i, raceTime in times do
	local record = distances[i]

	local wins = 0

	for timeHeld = 0, raceTime do
		local timeRemaining = raceTime - timeHeld
		local distance = timeRemaining * timeHeld

		if distance > record then
			wins += 1
		end
	end

	lastWin = lastWin * wins
end

print(lastWin)
