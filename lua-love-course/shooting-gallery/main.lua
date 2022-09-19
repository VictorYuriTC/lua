function love.load()
  target = {}
  target.radius = 50
  target.x = math.random(love.graphics.getWidth())
  target.y = math.random(love.graphics.getHeight())

  score = 0
  timer = 10

  gameFont = love.graphics.newFont(40)
end

function love.update(dt)
  if timer > 0 then
    timer = timer - dt
  end

  if timer < 0 then
    timer = 0
  end
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score, 0, 0)
  love.graphics.setFont(gameFont)

  love.graphics.print(math.ceil(timer), 300, 0)

  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", target.x, target.y, 50)
end

function love.mousepressed(x, y, button, istouch, presses)
  if button == 1 then
    local mouseToTarget = distanceBetween(x, y, target.x, target.y)
    if mouseToTarget < target.radius then
      score = score + 1
      target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
      target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
    end
  end
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
