function __TS__ArrayFilter(arr, callbackfn)
	local result = {}
	do
		local i = 0
		while i < #arr do
			if callbackfn(_G, arr[i + 1], i, arr) then
				result[#result + 1] = arr[i + 1]
			end
			i = i + 1
		end
	end
	return result
end
local function local__TS__ArrayFilter(arr, callbackfn)
	local result = {}
	do
		local i = 0
		while i < #arr do
			if callbackfn(_G, arr[i + 1], i, arr) then
				result[#result + 1] = arr[i + 1]
			end
			i = i + 1
		end
	end
	return result
end
local function __TS__ArrayFilter_NO_G(arr, callbackfn)
	local result = {}
	do
		local i = 0
		while i < #arr do
			if callbackfn(nil, arr[i + 1], i, arr) then
				result[#result + 1] = arr[i + 1]
			end
			i = i + 1
		end
	end
	return result
end
function ArrayFilter_FOR(arr, callbackfn)
	local result = {}
	for i = 0, #arr do
		if callbackfn(_G, arr[i + 1], i, arr) then
			result[#result + 1] = arr[i + 1]
		end
	end
	return result
end

function __TS__ArrayPush(arr, ...)
	local items = {...}
	for ____, item in ipairs(items) do
		arr[#arr + 1] = item
	end
	return #arr
end
local function ArrayPushFORI(arr, ...)
	local items = {...}
	for i=1,#items do
		arr[#arr+1] = items[i]
	end
	return #arr
end
local function ArrayPushWHILE(arr, ...)
	local items = {...}
	local i = 0
	while(i<#items) do
		arr[#arr+1] = items[i]
		i = i + 1
	end
	return #arr
end
local function ArrayPushtable(arr,...)
	local items = {...}
	table.Add(arr, items)
end
local function benchmark(name, func)
	local times = {}
	local starttime = SysTime()
	for i=0,10000 do
		func()
	end
	local endtime = SysTime()
	print("Benchmark: '" .. name .. "' - " .. endtime-starttime .. " s")
end

benchmark("array-filter.ts", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	arraytest = __TS__ArrayFilter(arraytest, function(globaltbl, v, i, array) return v~=0 end)
	return arraytest
end)

benchmark("local-array-filter.ts", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	arraytest = local__TS__ArrayFilter(arraytest, function(globaltbl, v, i, array) return v~=0 end)
	return arraytest
end)

benchmark("noglobal-array-filter.ts", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	arraytest = __TS__ArrayFilter_NO_G(arraytest, function(globaltbl, v, i, array) return v~=0 end)
	return arraytest
end)
benchmark("for-array-filter.ts", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	arraytest = ArrayFilter_FOR(arraytest, function(globaltbl, v, i, array) return v~=0 end)
	return arraytest
end)


benchmark("ipairs-array-push", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	__TS__ArrayPush(arraytest, 1,23,5,12,3,65,2,3,12,512335,76,322,52,421,31,5,15,25,21,3512,3,412,521,65,12342,52,52,4,2321235,2)
	return arraytest
end)
benchmark("fori-array-push", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	ArrayPushFORI(arraytest, 1,23,5,12,3,65,2,3,12,512335,76,322,52,421,31,5,15,25,21,3512,3,412,521,65,12342,52,52,4,2321235,2)
	return arraytest
end)
benchmark("while-array-push", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	ArrayPushWHILE(arraytest, 1,23,5,12,3,65,2,3,12,512335,76,322,52,421,31,5,15,25,21,3512,3,412,521,65,12342,52,52,4,2321235,2)
	return arraytest
end)
benchmark("table.Add-array-push", function()
	local arraytest = {0,0,0,1,1,1,1,1,1,1,1,1,1,2,452,23,0,12,50,6,6,0,21,3,6,23,521,512,536,33,0}
	ArrayPushtable(arraytest, 1,23,5,12,3,65,2,3,12,512335,76,322,52,421,31,5,15,25,21,3512,3,412,521,65,12342,52,52,4,2321235,2)
	return arraytest
end)
