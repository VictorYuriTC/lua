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
    print('Random position')
  elseif user_option == 2 then
    print('Distance')
  elseif user_option == 3 then
    print('Angle')
  else
    print('There is no option with this number')
  end

end

print('Thank you, goodbye!')