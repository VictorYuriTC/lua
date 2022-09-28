level = 1
num_lives = 5
score = 0
time_ellapsed = 0

if score >= 1000 then 
  level = level + 1
  num_lives = 5
else
  time_ellapsed = time_ellapsed + 1
end

print('Level: '..level)
print('Score: '..score)
print('Lives: '..num_lives)
print('Timer: '..time_ellapsed)