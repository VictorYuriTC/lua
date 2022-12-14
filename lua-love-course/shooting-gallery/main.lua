function love.load()
  target = {}
  target.radius = 50
  target.x = math.random(love.graphics.getWidth())
  target.y = math.random(love.graphics.getHeight())

  score = 0
  timer = 0
  gameState = 1

  gameFont = love.graphics.newFont(40)

  sprites = {}
  sprites.sky = love.graphics.newImage('sprites/sky.png')
  sprites.target = love.graphics.newImage('sprites/target.png')
  sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')

  love.mouse.setVisible(false)
end

function love.update(dt)
  if timer > 0 then
    timer = timer - dt
  end

  if timer < 0 then
    timer = 0
    gameState = 1
  end

  if score < 0 then
    score = 0
  end
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(sprites.sky, 0, 0)

  love.graphics.setColor(1, 1, 1)
  love.graphics.print('Score: ' ..score, 5, 5)
  love.graphics.setFont(gameFont)

  love.graphics.print('Time: ' ..math.ceil(timer), love.graphics.getWidth() / 2 - 70, 5)

  if gameState == 2 then
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
  end

  love.graphics.setColor(0, 1, 0)
  love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)

  if gameState == 1 then
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Click anywhere to begin!", 0, 250, love.graphics.getWidth(), 'center')
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  local mouseToTarget = distanceBetween(x, y, target.x, target.y)

  if button == 1 and gameState == 2 then
    if mouseToTarget < target.radius then
      score = score + 1
      target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
      target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
    end

    if mouseToTarget >= target.radius then
      score = score - 1
    end

  elseif button == 1 and gameState == 1 then
    gameState = 2
    timer = 10
    score = 0
  end

  if button == 2 and gameState == 2 then
    if mouseToTarget < target.radius then
      score = score + 2
      target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
      target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
      timer = timer - 1
    end

    if mouseToTarget >= target.radius then
      score = score - 1
      timer = timer - 1
    end
  end
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
