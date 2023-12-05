local fs = require("@lune/fs")
local input = fs.readFile("../inputs/day1.txt")

function recoverCalibrationValue(str: string)
	local digits = str:gsub("%a", ""):split("")

	return tonumber(digits[1] .. digits[#digits])
end

local values = input:split("\n")

local answer = 0
for _, value in pairs(values) do
	answer = answer + recoverCalibrationValue(value)
end

print(answer)
