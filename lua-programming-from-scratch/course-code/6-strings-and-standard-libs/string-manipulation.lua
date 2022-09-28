color = '#ce10e3'

pure_color = string.upper(string.gsub(color, '#', ''))

print(color)
print('Pure color: '..pure_color)

new_color = string.sub(color, 2, string.len(color))

print(new_color)

last_color = string.sub(color, 2, #color)

print(last_color)

email = 'victoryuritc@yahoo.com'
print(string.find(email, '@'))