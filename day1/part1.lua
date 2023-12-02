local input = require("day1/input").input

function recoverCalibrationValue(str: string): number
	local digits = str:gsub("%a", ""):split("")
	return tonumber(digits[1] .. digits[#digits]) :: number
end

local values = input:split("\n")
local answer = 0
for _, value in pairs(values) do
	answer = answer + recoverCalibrationValue(value)
end

print(answer)
