function love.load()
  anim8 = require 'libraries/anim8/anim8'

  sprites = {}
  sprites.playerSheet = love.graphics.newImage('sprites/playerSheet.png')

  wf = require 'libraries/windfield/windfield'
  world = wf.newWorld(0, 800, false)

  world:addCollisionClass('Platform')
  world:addCollisionClass('Player')
  world:addCollisionClass('Danger')

  player = world:newRectangleCollider(360, 100, 80, 80, { collision_class = 'Player' })
  player.speed = 240
  player:setFixedRotation(true)

  platform = world:newRectangleCollider(250, 400, 300, 100, { collision_class = 'Platform' })
  platform:setType('static')

  dangerZone = world:newRectangleCollider(0, 550, 800, 50, { collision_class = 'Danger' })
  dangerZone:setType('static')
end

function love.update(dt)
  world:update(dt)

  playerMovimentation()
  playerPerishesWhenEnteringDangerZone()
end

function love.draw()
  world:draw()
end

function love.keypressed(key)
  if key == 'up' or key == 'space' then
    local colliders = world:queryRectangleArea(player:getX() - 40, player:getY() + 40, 80, 2, {'Platform'})
    
    if #colliders > 0 then
      player:applyLinearImpulse(0, -7000)
    end
  end
end

function love.mousepressed(x, y, button, isTouch)
  if button == 1 then
    local colliders = world:queryCircleArea(x, y, 200, { 'Danger' })
    for i, c in ipairs(colliders) do
      c:destroy()
    end
  end
end

function playerMovimentation()
  if player.body then
    local px, py = player:getPosition()

    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
      player:setX(px + 5)
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
      player:setX(px - 5)
    end
  end
end

function playerPerishesWhenEnteringDangerZone()
  if player:enter('Danger') then
    player:destroy()
  end
end