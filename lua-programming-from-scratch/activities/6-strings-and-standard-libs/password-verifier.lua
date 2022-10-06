--[[ 3. Create a script in Lua that initializes a variable with the password string value. The program should display if the password is valid. For a password to be valid, the password should not contain spaces and should have at least 6 characters. ]]

password = ' sord'

has_space_char = string.find(password, ' ')

function getPasswordVerifierMessage()
  if #password >= 6 and
  not has_space_char then
    return "It's a valid password!"
  end

  if has_space_char and
  #password < 6 then
    return "That's completely wrong! Passwords cannot have space between characters and at least 6 characters are required for a password."
  end

  if has_space_char then
    return "Passwords cannot have space between characters!"
  end

  if #password < 6 then
    return "Passwords must have at least 6 characters!"
  end
end

print(getPasswordVerifierMessage())