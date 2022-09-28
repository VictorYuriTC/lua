--[[ 2. Create a script that initializes a string value with the email of an user. The program should display if that variable contains a valid email. The requirements for the value to be a valid email are:

a) The email should contain an “@” character

b) The email should contain a “.” character

c) The “@” should occur before the “.” character

d) The email should not contain any spaces. ]]

email = 'victoryuritc@yahoo.com'

has_at_char = string.find(email, '%@')
has_dot_char = string.find(email, '%.')
has_space_char = string.find(email, ' ')

function getEmailVerifierMessage()
  if not has_space_char and
  has_at_char and
  has_dot_char then
  if has_at_char < has_dot_char then
    return "It's a valid email!"
  end

  if has_at_char > has_dot_char then
    return "Invalid email. At sign must come before dot sign!"
  end
  else
    return "Invalid email! At sign and dot sign are required in all email!"
  end
end

print(getEmailVerifierMessage())