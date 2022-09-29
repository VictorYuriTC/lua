people = {
  gabi = 'Gabriela',
  paulo = 'Paulo',
  ricardo = 'Ricardo'
}

for k, v in pairs(people) do
  print(k, v)
end

countries = {
  6,
  50,
  Turkey,
  10
}

for index, country in ipairs(countries) do
  print(countries[index])
end