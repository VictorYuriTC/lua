enemies = {}

function spawnEnemy(x, y)
  local enemy = world:newRectangleCollider(x, y, 70, 90, { collision_class = 'Danger'} )
  enemy.direction = 1
  enemy.speed = 200
  enemy.animation = animations.enemy
  table.insert(enemies, enemy)
end

function updateEnemies(dt)
  for i, enemy in ipairs(enemies) do
    enemy.animation:update(dt)

    local enemyX, enemyY = enemy:getPosition()

    local colliders = world:queryRectangleArea(enemyX + (40 * enemy.direction), enemyY + 40, 10, 10, { 'Platform' })

    if #colliders == 0 then
      enemy.direction = enemy.direction * -1
    end
    enemy:setX(enemyX + enemy.speed * dt * enemy.direction)
  end
end

function drawEnemies()
  for i, enemy in ipairs(enemies) do
    local enemyX, enemyY = enemy:getPosition()
    enemy.animation:draw(sprites.enemySheet, enemyX, enemyY, nil, enemy.direction, 1, 50, 65)
  end
end