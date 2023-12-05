--!native

local input = require("day5/input").input
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
		local destStart, srcStart, length = line:match("(.*) (.*) (.*)")
		local data = { destStart = tonumber(destStart), srcStart = tonumber(srcStart), length = tonumber(length) }

		if rulesets[currMap] then
			table.insert(rulesets[currMap], data)
		else
			rulesets[currMap] = { data }
		end
	end
end

local minimum

function testRule(num: number, rule: { destStart: number, srcStart: number, length: number })
	local diff = num - rule.srcStart
	local dest = rule.destStart + diff
	if dest >= rule.destStart and dest <= rule.destStart + rule.length then
		return dest
	else
		return nil
	end
end

-- This works, but is unbearably slow. Took almost an hour. See part2_better.lua for a better solution.
for _, range in seedRanges do
	for seed = range.starts, range.ends do
		local last = tonumber(seed)

		for _, ruleset in rulesets do
			for _, rule in ruleset do
				local passed = testRule(last, rule)
				if passed then
					last = passed
					break
				end
			end
		end

		if not minimum or last < minimum then
			minimum = last
		end
	end
end

print(minimum)
