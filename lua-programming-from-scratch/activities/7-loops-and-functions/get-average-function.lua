--[[ 1. Create a simple Lua function that receives five parameters and returns the result of the average of these five values.]]

function get_average_from_five_numbers(a, b, c, d, e)
  return (a + b + c + d + e) / 5
end

print(get_average_from_five_numbers(3, 3, 1, 2, 1))