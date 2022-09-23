function love.load()
  wf = require 'libraries/windfield/windfield'
  anim8 = require 'libraries/anim8/anim8'
  sti = require 'libraries/Simple-Tiled-Implementation/sti'
  cameraFile = require 'libraries/hump/camera'

  cam = cameraFile()

  world = wf.newWorld(0, 800, false)

  sprites = {}
  sprites.playerSheet = love.graphics.newImage('sprites/santasprites/png/Idle (1).png')
  sprites.background = love.graphics.newImage('sprites/wintertileset/bg/bg.png')

  animations = {}

  local playerGrid = anim8.newGrid(614, 564, sprites
    .playerSheet:getWidth(), sprites.playerSheet:getHeight())

  animations.playerIdle = anim8.newAnimation(playerGrid('1-1', 1), 0.05)

  world:addCollisionClass('Player')
  world:addCollisionClass('Danger')

  require('player')
  require('enemy')

  enemies = {}

  platforms = {}

  loadMap()
  
end
  
function love.update(dt)
  world:update(dt)
  gameMap:update()
  playerFunctions.playerBasicMovimentation()
  playerFunctions.playerPerishWhenInDangerZone()
  makeCameraVisionFollowPlayer()
end
  
function love.draw()
  love.graphics.draw(sprites.background, 0, 0)
  cam:attach()
    world:draw()
    gameMap:drawLayer(gameMap.layers['WinterTiles'])
    playerFunctions.drawPlayer()
  cam:detach()
end
  
function love.keypressed(key)

  if key == 'space' or key == 'up' then
    player:applyLinearImpulse(0, -4000)
  end
  
end

function makeCameraVisionFollowPlayer()
  local px, py = player:getPosition()
  cam:lookAt(px, py)
end

function loadMap()
  gameMap = sti('maps/level1.lua')

  for index, startPoint in pairs(gameMap.layers['StartPoint'].objects) do
    playerStartX = startPoint.x
    playerStartY = startPoint.y
  end

  for index, platform in pairs(gameMap.layers['Platforms'].objects) do
    spawnPlatform(platform.x, platform.y, platform.width, platform.height)
  end

  for index, enemy in pairs(gameMap.layers['Enemies'].objects) do
    enemyFunctions.spawnEnemy(enemy.x, enemy.y)
  end
end

function spawnPlatform(x, y, width, height)
  if width == 0 or height == 0 then
    return
  end

  local platform = world:newRectangleCollider(x, y, width, height, { collision_class = 'Platform' })
  platform:setType('static')
  
  table.insert(platforms, platform)
end
