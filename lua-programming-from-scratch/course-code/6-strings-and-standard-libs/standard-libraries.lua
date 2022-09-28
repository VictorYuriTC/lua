-- os lib
-- math lib

math.randomseed(os.time())

print(math.floor(4.687))
print(math.pi)
print(math.random())
print(math.random(100, 200))

enemy_x = math.random(0, 800)
enemy_y = math.random(0, 600)

print('Enemy pos: ('..enemy_x..','..enemy_y..')')