player = world:newRectangleCollider(100, 0, 40, 100, { collision_class = 'Player' })

playerFunctions = {}

playerFunctions.playerBasicMovimentation = function()
  local px, py = player:getPosition()

  if love.keyboard.isDown('a') then
    player:setX(px - 4)
  end

  if love.keyboard.isDown('d') then
    player:setX(px + 4)
  end
end