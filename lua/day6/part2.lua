local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day6.txt")

local lines = input:split("\n")

local raceTime = ""
for segment in lines[1]:gmatch("%d+") do
	raceTime = raceTime .. segment
end
raceTime = tonumber(raceTime)

local record = ""
for segment in lines[2]:gmatch("%d+") do
	record = record .. segment
end
record = tonumber(record)

local wins = 0

for timeHeld = 0, raceTime do
	local timeRemaining = raceTime - timeHeld
	local distance = timeRemaining * timeHeld

	if distance > record then
		wins += 1
	end
end

print(wins)
