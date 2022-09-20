function love.load()
  wf = require 'libraries/windfield/windfield'
  world = wf.newWorld(0, 800)

  player = world:newRectangleCollider(360, 100, 80, 80)
  platform = world:newRectangleCollider(250, 400, 300, 100)
  platform:setType('static')
end

function love.update(dt)
  world:update(dt)

  playerMovimentation()


end

function love.draw()
  world:draw()
end

function love.keypressed(key)
  if key == 'up' or key == 'space' then
    player:applyLinearImpulse(0, -5000)
  end
end

function playerMovimentation()
  local px, py = player:getPosition()

  if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
    player:setX(px + 5)
  end

  if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
    player:setX(px - 5)
  end
end