math.randomseed(os.time())

local player_x, player_y = 400, 300
local num_enemies = 0

while num_enemies < 500 do
  local enemy_x = math.random(0, 800)
  local enemy_y = math.random(0, 600)

  if (player_x == enemy_x and
  player_y == enemy_y) then
    print("Enemy and player position clashed!")
  else
    num_enemies = num_enemies + 1
    print("Enemy "..num_enemies..":("..enemy_x..","..enemy_y..")")
  end
end

print('Thank you, goodbye!')