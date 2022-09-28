--[[ 4. Create a Lua script that initializes a variable with a number between 1 and 6. The script should also generate a random number between 1 and 6 (simulating the roll of a dice). The program should display a message if both numbers are equal or different, meaning that we guessed the random dice roll correctly or not.]]

math.randomseed(os.time())

my_number = 5
random_number = math.random(1, 6)

function getMessageAfterRollingTheDice()
  print("You've picked the number "..my_number)
  print("And the dice gave us...")
  print(random_number.. "!")
  if my_number == random_number then
    return "Hooray, you got it right, man!"
  end

  if my_number ~= random_number then
    return "Wrong guess, better luck next time, son..."
  end
end

print(getMessageAfterRollingTheDice())