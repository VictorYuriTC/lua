math.randomseed(os.time())

player_x, player_y = 400, 300

num_enemies = 0

while num_enemies < 500 do
  enemy_x = math.random(0, 800)
  enemy_y = math.random(0, 600)

  if (player_x == enemy_x or
  player_y == enemy_y) then
    print("Enemy and player position clashed!")
  else
    num_enemies = num_enemies + 1
    print("Enemy "..num_enemies..":("..enemy_x..","..enemy_y..")")
  end
end

print('Thank you, goodbye!')