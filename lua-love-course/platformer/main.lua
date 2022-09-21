function love.load()
  love.window.setMode(1000, 768)

  wf = require 'libraries/windfield/windfield'
  anim8 = require 'libraries/anim8/anim8'
  sti = require 'libraries/Simple-Tiled-Implementation/sti'
  cameraFile = require 'libraries/hump/camera'
  
  cam = cameraFile()

  sprites = {}
  sprites.playerSheet = love.graphics.newImage('sprites/playerSheet.png')
  sprites.enemySheet = love.graphics.newImage('sprites/enemySheet.png')

  local grid = anim8.newGrid(614, 564, sprites
    .playerSheet:getWidth(), sprites.playerSheet:getHeight())

  local enemyGrid = anim8.newGrid(100, 79, sprites
    .enemySheet:getWidth(), sprites.enemySheet:getHeight())

  animations = {}
  animations.idle = anim8.newAnimation(grid('1-15', 1), 0.05)
  animations.jump = anim8.newAnimation(grid('1-7', 2), 0.05)
  animations.run = anim8.newAnimation(grid('1-15', 3), 0.05)
  animations.enemy = anim8.newAnimation(enemyGrid('1-2', 1), 0.03)

  world = wf.newWorld(0, 800, false)

  world:addCollisionClass('Platform')
  world:addCollisionClass('Player')
  world:addCollisionClass('Danger', { ignores = { 'Danger' }})

  require('player')
  require('enemy')
  
  platforms = {}

  loadMap()
end

function love.update(dt)
  world:update(dt)
  gameMap:update(dt)

  PlayerTable.playerIdleMovimentation()
  PlayerTable.playerRunningMovimentation()
  PlayerTable.playerPerishesWhenEnteringDangerZone()
  PlayerTable.playerJumpingMovimentation()
  PlayerTable.playerChangeAnimation()
  PlayerTable.playerAnimationUpdate(dt)

  updateEnemies(dt)

  destroyAreaOnClicking()
  makeCameraVisionFollowPlayer()

end

function love.draw()
  cam:attach()
  drawEnemies()
    gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
    world:draw()

    PlayerTable.drawPlayer()
  cam:detach()
end

function makeCameraVisionFollowPlayer()
  if not PlayerTable.isPlayerAlive() then
    return
  end

  local px, py = player:getPosition()
  cam:lookAt(px, love.graphics.getHeight() / 2)
end

function loadMap()
  gameMap = sti("maps/level1.lua")

  for i, platform in pairs(gameMap.layers["Platforms"].objects) do
    spawnPlatform(platform.x, platform.y, platform.width, platform.height)
  end

  for i, enemy in pairs(gameMap.layers["Enemies"].objects) do
    spawnEnemy(enemy.x, enemy.y, enemy.width, enemy.height)
  end
end

function spawnPlatform(x, y, width, height)
  if width == 0 or height == 0 then
    return
  end

  local platform = world:newRectangleCollider(x, y, width, height, { collision_class ='Platform' })
  platform:setType('static')
  
  table.insert(platforms, platform)
end

function destroyAreaOnClicking()
  function love.mousepressed(x, y, button, isTouch)
    if button == 1 then
      local colliders = world:queryCircleArea(x, y, 200, { 'Danger' })
      for i, c in ipairs(colliders) do
        c:destroy()
      end
    end
  end
end