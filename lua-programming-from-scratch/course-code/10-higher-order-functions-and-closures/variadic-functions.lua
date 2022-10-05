function find_max(...)
  local n = 0
  local arguments = {...}
  local max = arguments[1]
  for i, num in ipairs(arguments) do
    if num > max then
      max = num
    end

    n = n + 1
  end
  
  return n, max
end

----------------------------------------
-- Ask for the max value of a list o integers
----------------------------------------

local n, max = find_max(4, 2, -3, 8, 6, 3, 7, 2, 4, 7)

print('The maximum of '..n..' values was '..max)