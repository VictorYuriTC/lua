--[[ 2. Create a Lua script that displays 20 random numbers between 1 and 6. ]]

math.randomseed(os.time())

local all_numbers = 1

repeat
  local random_generated_number = math.random(1, 6)
  print(random_generated_number)
  all_numbers = all_numbers + 1
until all_numbers == 20

