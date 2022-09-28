math.randomseed(os.time())

for c = 1, 500, 25 do
  enemy_x = math.random(0, 800)
  enemy_y = math.random(0, 600)

  print("Enemy "..c.. " pos: ("..enemy_x..","..enemy_y..')')
end

print('Thank you, goodbye!')