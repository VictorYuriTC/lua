txt = io.read('all')
txt = io.read('*a')
txt = io.read('*n')
txt = io.read('*l')
txt = io.read(4)
a, b = io.read(4, 6)
a, b = io.read('*n', '*n')

local num = tonumber(io.read())