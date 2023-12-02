local input = require("day1/input").input

local charDigits = {
	["one"] = 1,
	["two"] = 2,
	["three"] = 3,
	["four"] = 4,
	["five"] = 5,
	["six"] = 6,
	["seven"] = 7,
	["eight"] = 8,
	["nine"] = 9,
	["1"] = 1,
	["2"] = 2,
	["3"] = 3,
	["4"] = 4,
	["5"] = 5,
	["6"] = 6,
	["7"] = 7,
	["8"] = 8,
	["9"] = 9,
}

function recoverCalibrationValue(str: string)
	local digits = {}

	for word, number in pairs(charDigits) do
		local pos = 1
		while true do
			local starts, ends = str:find(word, pos, true)
			if starts then
				table.insert(digits, { position = starts, number = number })
				pos = ends + 1
			else
				break
			end
		end
	end

	table.sort(digits, function(a, b)
		return a.position < b.position
	end)

	return tonumber(digits[1].number .. digits[#digits].number)
end

local values = input:split("\n")
local answer = 0
for _, value in pairs(values) do
	local calibrated = recoverCalibrationValue(value)
	print(value, calibrated)
	answer = answer + calibrated
end

print(answer)
