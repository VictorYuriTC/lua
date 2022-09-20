pi = math.pi

function love.load()
  sprites = {}
  sprites.background = love.graphics.newImage('sprites/background.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')

  player = {}
  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() / 2

  player.speed = 180

  zombies = {}
  bullets = {}
end

function love.update(dt)
  local playerSpeed = player.speed
  local playerX = player.x
  local playerY = player.y

  if love.keyboard.isDown('d') then
    player.x = playerX + playerSpeed * dt
  end

  if love.keyboard.isDown('a') then
    player.x = playerX - playerSpeed * dt
  end

  if love.keyboard.isDown('w') then
    player.y = playerY - playerSpeed * dt
  end

  if love.keyboard.isDown('s') then
    player.y = playerY + playerSpeed * dt
  end

  for i,z in ipairs(zombies) do
    z.x = z.x + (math.cos(zombiePlayerAngle(z)) * z.speed * dt)
    z.y = z.y + (math.sin(zombiePlayerAngle(z)) * z.speed * dt)

    if distanceBetween(z.x, z.y, player.x, player.y) < 40 then
      for i,z in ipairs(zombies) do
        zombies[i] = nil
      end
    end
  end

  for i,b in ipairs(bullets) do
    b.x = b.x + (math.cos(b.direction) * b.speed * dt)
    b.y = b.y + (math.sin(b.direction) * b.speed * dt)
  end

  for i=#bullets, 1, -1 do
    local b = bullets[i]

    if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getWidth() then
      table.remove(bullets, i)
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

  love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, playerAnchorX, playerAnchorY)

  for i,z in ipairs(zombies) do
    love.graphics.draw(sprites.zombie, z.x, z.y, zombiePlayerAngle(z), nil, nil, zombieAnchorX, zombieAnchorY)
  end

  for i,b in ipairs(bullets) do
    love.graphics.draw(sprites.bullet, b.x, b. y, nil, 0.2, 0.2)
  end
end

function playerMouseAngle()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + pi
end

function zombiePlayerAngle(enemy)
  return math.atan2(player.y - enemy.y, player.x - enemy.x)
end

function love.mousepressed(x, y, button)
  if button == 1 then
    spawnBullet()
  end
end

function love.keypressed(key)
  if key == 'space' then
    spawnZombie()
  end
end

function spawnZombie()
  local zombie = {}
  zombie.x = math.random(0, love.graphics.getWidth())
  zombie.y = math.random(0, love.graphics.getHeight())
  zombie.speed = 140
  table.insert(zombies, zombie)
end

function spawnBullet()
  local bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.speed = 500
  bullet.direction = playerMouseAngle()
  table.insert(bullets, bullet)
end


function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end