blanka = Fighter:new({
  name = 'Blanka',
  health = 100,
  speed = 60
})
print('Object '..blanka.name.. ' was created.')

chun_li = Fighter:new({
  name = 'Chun Li',
  health = 100,
  speed = 85
})
print('Object '..chun_li.name.. ' was created.')

blanka:light_punch()
blanka:heavy_kick()
blanka:special_attack()

chun_li:light_punch()
chun_li:heavy_kick()
chun_li:special_attack()
