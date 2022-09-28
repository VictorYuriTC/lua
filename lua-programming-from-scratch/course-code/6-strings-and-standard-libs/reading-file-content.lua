local file = io.open(arg[1], 'r')

print(arg[0], arg[1])

local text = file:read('all')

file:close()

print(text)