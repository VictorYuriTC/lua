math.randomseed(os.time())

local player_x, player_y = 400, 300

local enemy_x = 0
local enemy_y = 0

local user_option = 0

while user_option ~= 4 do
  print('+--------------------------')
  print('| Welcome, '..os.date())
  print('+--------------------------')
  print('| 1. Generate random enemy position')
  print('| 2. Distance from enemy to player')
  print('| 3. Get angle from enemy to')
  print('| 4. Exit')
  print('+--------------------------')

  print('Please, select your option: ')

  user_option = io.read('*n')

  if user_option == 1 then
    enemy_x = math.random(0, 800)
    enemy_y = math.random(0, 600)
    print('New enemy pos ('..enemy_x..','..enemy_y..')')
  elseif user_option == 2 then
    local distance = math.sqrt((player_x - enemy_x)^2 + (player_y - enemy_y)^2)
    print('Distance from enemy to: '..distance)
  elseif user_option == 3 then
    local angle_radians = math.atan2((player_y - enemy_y), (player_x - enemy_x))
    local angle_degrees = math.deg(angle_radians)
    print('Angle between enemy and player is '..angle_degrees)
  elseif user_option == 4 then
    print("Right!")
  else
    print('There is no option with this number')
  end

end

print('Thank you, goodbye!')