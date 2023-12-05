local inspect = require("util/inspect")
local input = require("day5/input").input

local lines = input:split("\n")

local seeds = lines[1]:split(" ")
table.remove(seeds, 1)

table.remove(lines, 1)
table.remove(lines, 1)

local maps = {}
local currMap = 1

for _, line in lines do
	if line == "" then
		currMap += 1
	elseif line:find("%d+") then
		local destStart, srcStart, length = line:match("(.*) (.*) (.*)")
		local data = { destStart = tonumber(destStart), srcStart = tonumber(srcStart), length = tonumber(length) }

		if maps[currMap] then
			table.insert(maps[currMap], data)
		else
			maps[currMap] = { data }
		end
	end
end

function testRule(num: number, rule: { destStart: number, srcStart: number, length: number })
	print(num, inspect(rule))
	local diff = num - rule.srcStart
	local dest = rule.destStart + diff
	if dest >= rule.destStart and dest <= rule.destStart + rule.length then
		return dest
	end
end

-- print(testMap(98, { srcStart = 98, destStart = 50, length = 2 }))
-- print(testMap(99, { srcStart = 98, destStart = 50, length = 2 }))
-- print(testMap(10, { srcStart = 98, destStart = 50, length = 2 }))

local endingNums = {}

for _, seed in seeds do
	local last = tonumber(seed)
	for _, map in maps do
		for _, rule in map do
			local passed = testRule(last, rule)
			if passed ~= nil then
				last = passed
				break
			end
		end
	end

	table.insert(endingNums, last)
end

print(math.min(table.unpack(endingNums)))
