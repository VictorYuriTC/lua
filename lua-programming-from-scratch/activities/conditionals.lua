fighter_name = 'HONDA'

if string.lower(fighter_name) == 'ryu' or
string.lower(fighter_name) == 'blanka' then
  attack_move = 'Hadouken'
elseif string.lower(fighter_name) == 'chun Li' then
  attack_move = 'Lightning kick'
elseif string.lower(fighter_name) == 'guile' then
  attack_move = 'Sonic boom'
elseif string.lower(fighter_name) == 'honda' then
  attack_move = 'Hundred Hand Slap'
elseif string.lower(fighter_name) == 'ken' then
  attack_move = 'Hadouken'
end

print(fighter_name.." attacks with "..attack_move)