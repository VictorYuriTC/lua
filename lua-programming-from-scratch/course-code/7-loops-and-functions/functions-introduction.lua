function display_menu()

  print('+--------------------------')
  print('| Welcome, '..os.date())
  print('+--------------------------')
  print('| 1. Generate random enemy position')
  print('| 2. Distance from enemy to player')
  print('| 3. Get angle from enemy to')
  print('| 4. Exit')
  print('+--------------------------')
  print('Please, select your option: ')

end

function get_distance(x1, x2, y1, y2)
  return math.sqrt((x1 - y1)^2 + (x2 - y2)^2)
end

player_x, player_y = 10, 20
enemy_x, enemy_y = 140, 130

display_menu()
print(get_distance(player_x, player_y, enemy_x, enemy_y))