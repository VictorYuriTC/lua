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

  tempRotation = 0
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

  tempRotation = tempRotation + 0.01
end

function love.draw()
  local playerAnchorX = sprites.player:getWidth() / 2
  local playerAnchorY = sprites.player:getHeight() / 2
  love.graphics.draw(sprites.background, 0, 0)

  love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, playerAnchorX, playerAnchorY)
end

function playerMouseAngle()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + pi
end