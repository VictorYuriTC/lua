pi = math.pi

function love.load()
  math.randomseed(os.time())

  sprites = {}
  sprites.background = love.graphics.newImage('sprites/background.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')

  player = {}
  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() / 2
  player.speed = 180

  menuFont = love.graphics.newFont(40)

  zombies = {}
  bullets = {}

  score = 0

  gameState = 1
  maxTime = 2
  timer = maxTime
end

function love.update(dt)
  playerMovimentation(dt)

  zombiesMovimentation(dt)
  gameOverWhenZombieHitsPlayer()

  bulletMovimentation(dt)

  removeBulletWhenPassingScreenBorders()

  whenHittingSetIsDeadAndHasHit()
  deleteZombieWhenHitting()
  deleteBulletWhenHitting()

  if gameState == 2 then
    timer = timer - dt
    if timer <= 0 then
      spawnZombie()
      maxTime = 0.95 * maxTime
      timer = maxTime
    end
  end
end

function love.draw()
  local playerAnchorX = sprites.player:getWidth() / 2
  local playerAnchorY = sprites.player:getHeight() / 2
  local zombieAnchorX = sprites.zombie:getWidth() / 2
  local zombieAnchorY = sprites.zombie:getHeight() / 2
  local bulletAnchorX = sprites.bullet:getWidth() / 2
  local bulletAnchorY = sprites.bullet:getHeight() / 2

  love.graphics.draw(sprites.background, 0, 0)

  if gameState == 1 then
    love.graphics.printf('Click anywhere to begin!', 0, 50, love.graphics.getWidth(), 'center')
    love.graphics.setFont(menuFont)
  end

  love.graphics.printf('Score: ' ..score, 15, love.graphics.getHeight() - 100, love.graphics.getWidth(), 'center')

  love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, playerAnchorX, playerAnchorY)

  for i,z in ipairs(zombies) do
    love.graphics.draw(sprites.zombie, z.x, z.y, zombiePlayerAngle(z), nil, nil, zombieAnchorX, zombieAnchorY)
  end

  for i,b in ipairs(bullets) do
    love.graphics.draw(sprites.bullet, b.x, b. y, nil, 0.2, 0.2)
  end
end

function playerMovimentation(dt)

  if love.keyboard.isDown('d') and player.x < love.graphics.getWidth() + 15 then
    player.x = player.x + player.speed * dt
  end

  if love.keyboard.isDown('a') and player.x > 15 then
    player.x = player.x - player.speed * dt
  end

  if love.keyboard.isDown('w') and player.y > 15 then
    player.y = player.y - player.speed * dt
  end

  if love.keyboard.isDown('s') and player.y < love.graphics.getHeight() + 15 then
    player.y = player.y + player.speed * dt
  end
end

function zombiesMovimentation(dt)
  for i,z in ipairs(zombies) do
    z.x = z.x + (math.cos(zombiePlayerAngle(z)) * z.speed * dt)
    z.y = z.y + (math.sin(zombiePlayerAngle(z)) * z.speed * dt)
  end
end

function gameOverWhenZombieHitsPlayer()
  local screenCenterX = love.graphics.getWidth() / 2
  local screenCenterY = love.graphics.getHeight() / 2

  for i,z in ipairs(zombies) do
    if distanceBetween(z.x, z.y, player.x, player.y) < 40 then
      for i,z in ipairs(zombies) do
        zombies[i] = nil
        gameState = 1
        player.x = screenCenterX
        player.y = screenCenterY
      end
    end
  end
end

function bulletMovimentation(dt)
  for i,b in ipairs(bullets) do
    b.x = b.x + (math.cos(b.direction) * b.speed * dt)
    b.y = b.y + (math.sin(b.direction) * b.speed * dt)
  end
end

function playerMouseAngle()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + pi
end

function zombiePlayerAngle(enemy)
  return math.atan2(player.y - enemy.y, player.x - enemy.x)
end

function love.mousepressed(x, y, button)
  if button == 1 and gameState == 2 then
    spawnBullet()

  elseif button == 1 and gameState == 1 then
    gameState = 2
    maxTime = 2
    timer = maxTime
    score = 0
  end
end

function zombieSpawnSideOne(enemy)
  enemy.x = -30
  enemy.y = math.random(0, love.graphics.getHeight())
end

function zombieSpawnSideTwo(enemy)
  enemy.x = love.graphics.getWidth() + 30
  enemy.y = math.random(0, love.graphics.getHeight())
end

function zombieSpawnSideThree(enemy)
  enemy.x = math.random(0, love.graphics.getWidth())
  enemy.y = -30
end

function zombieSpawnSideFour(enemy)
  enemy.x = math.random(0, love.graphics.getWidth())
  enemy.y = love.graphics.getHeight() + 30
end


function spawnZombie()
  local zombie = {}
  local side = math.random(1, 4)

  zombie.x = 0
  zombie.y = 0
  zombie.speed = 140
  zombie.isDead = false
  table.insert(zombies, zombie)

  local side = math.random(1, 4)

  if side == 1 then
    zombieSpawnSideOne(zombie)
  elseif side == 2 then
    zombieSpawnSideTwo(zombie)
  elseif side == 3 then
    zombieSpawnSideThree(zombie)
  elseif side == 4 then
    zombieSpawnSideFour(zombie)
  end
end

function deleteZombieWhenHitting()
  for i=#zombies, 1, -1 do
    local z = zombies[i]
    if z.isDead then
      table.remove(zombies, i)
      score = score + 50
    end
  end
end

function spawnBullet()
  local bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.speed = 500
  bullet.hasHit = false
  bullet.direction = playerMouseAngle()
  table.insert(bullets, bullet)
end

function deleteBulletWhenHitting()
  for i=#bullets, 1, -1 do
    local b = bullets[i]
    if b.hasHit then
      table.remove(bullets, i)
    end
  end
end

function removeBulletWhenPassingScreenBorders()
  for i=#bullets, 1, -1 do
    local b = bullets[i]

    if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getWidth() then
      table.remove(bullets, i)
    end 
  end
end

function whenHittingSetIsDeadAndHasHit()
  for i,z in ipairs(zombies) do
    for j, b in ipairs(bullets) do
      if distanceBetween(z.x, z.y, b.x, b.y) < 22 then
        z.isDead = true
        b.hasHit = true
      end
    end
  end
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end