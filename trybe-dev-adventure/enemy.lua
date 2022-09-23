enemyFunctions = {}

enemyFunctions.spawnEnemy = function(x, y)
  local enemy = world:newRectangleCollider(x, y, 60, 100, { collision_class = 'Danger' })
  enemy.direction = 1
  enemy.speed = 180
  enemy:setType('dynamic')

  table.insert(enemies, enemy)
end