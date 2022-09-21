playerStartX = 0
playerStartY = 0

player = world:newRectangleCollider(100, 0, 40, 100, { collision_class = 'Player' })
player:setFixedRotation(true)
player.direction = 1
player.animation = animations.playerIdle

playerFunctions = {}

playerFunctions.playerBasicMovimentation = function()
  local px, py = player:getPosition()

  if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
    player:setX(px - 4)
  end

  if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
    player:setX(px + 4)
  end
end

playerFunctions.drawPlayer = function()
  local px, py = player:getPosition()
  player.animation:draw(sprites.playerSheet, px, py, nil, 0.20 * player.direction, 0.20, 380, 300)
end