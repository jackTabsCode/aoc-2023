--!native

local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day5.txt")
local lines = input:split("\n")

local seedRanges = {}

for match in lines[1]:gmatch("%d+ %d+") do
	local seed, length = match:match("(.*) (.*)")
	seed, length = tonumber(seed), tonumber(length)
	table.insert(seedRanges, { starts = seed, ends = seed + length })
end

table.remove(lines, 1)
table.remove(lines, 1)

local rulesets = {}
local currMap = 1

for _, line in lines do
	if line == "" then
		currMap += 1
	elseif line:find("%d+") then
		local output, starts, length = line:match("(.*) (.*) (.*)")
		output, starts, length = tonumber(output), tonumber(starts), tonumber(length)
		local data = { output = output, starts = starts, ends = starts + length }

		if rulesets[currMap] then
			table.insert(rulesets[currMap], data)
		else
			rulesets[currMap] = { data }
		end
	end
end

local minimum = math.huge

-- Runs instantly, full credit to a friend who helped me
for _, range in seedRanges do
	local seed = range.starts
	while seed <= range.ends do
		local value = seed
		local skip = math.huge

		for _, ruleset in rulesets do
			for _, rule in ruleset do
				if value >= rule.starts and value < rule.ends then
					skip = math.min(skip, rule.ends - value)
					value -= rule.starts
					value += rule.output
					break
				end
			end
		end

		seed += skip
		minimum = math.min(minimum, value)
	end
end

print(minimum)
