students = {
  { name = 'Miles Davis', instrument = 'trumpet' },
  { name = 'John Coltrane', instrument = 'saxophone' },
  { name = 'Bill Evans', instrument = 'piano' },
  { name = 'Wynton Kelly', instrument = 'piano' }
}

for key, value in pairs(students) do
  for k, v in pairs(value) do
    print(k, v)
  end
end