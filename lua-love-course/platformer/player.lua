player = world:newRectangleCollider(360, 100, 40, 100, { collision_class = 'Player' })
player:setFixedRotation(true)
player.speed = 240
player.animation = animations.idle
player.isMoving = false
player.isJumping = false
player.direction = 1

PlayerTable = {}

PlayerTable.isPlayerAlive = function()
  if player.body then
    return true
  end

  return false
end

PlayerTable.drawPlayer = function()
  if not PlayerTable.isPlayerAlive() then
    return
  end

  local px, py = player:getPosition()
  player.animation:draw(sprites.playerSheet, px, py, nil, 0.25 * player.direction, 0.25, 150, 300)
end

PlayerTable.playerIdleMovimentation = function()
  if not PlayerTable.isPlayerAlive() then
    return
  end

  local colliders = world:queryRectangleArea(player:getX() - 20, player:getY() + 50, 40, 2, {'Platform'})

  if #colliders > 0 then
    player.isMoving = false
    player.isJumping = false
  end
end

PlayerTable.playerRunningMovimentation = function()
  if not PlayerTable.isPlayerAlive() then
    return
  end

  local px, py = player:getPosition()

  if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
    player:setX(px + 5)
    player.isMoving = true
    player.direction = 1
  end

  if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
    player:setX(px - 5)
    player.isMoving = true
    player.direction = -1
  end
  
end

PlayerTable.playerJumpingMovimentation = function()
  function love.keypressed(key)
    if not PlayerTable.isPlayerAlive() then
      return
    end

    local colliders = world:queryRectangleArea(player:getX() - 20, player:getY() + 50, 40, 2, {'Platform'})

    if key == 'up' or key == 'space' then
      if #colliders > 0 then
        player:applyLinearImpulse(0, -4000)
        player.isJumping = true
      end
    end

    if #colliders == 0 then
      player.isJumping = true
    end
  end
end

PlayerTable.playerChangeAnimation = function()
  if player.isMoving then
    player.animation = animations.run
  end

  if not player.isMoving then
    player.animation = animations.idle
  end

  if player.isJumping then
    player.animation = animations.jump
  end
end

PlayerTable.playerPerishesWhenEnteringDangerZone = function()
  if player:enter('Danger') then
    player:destroy()
  end
end