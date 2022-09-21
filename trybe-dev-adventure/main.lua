function love.load()
  wf = require 'libraries/windfield/windfield'
  anim8 = require 'libraries/anim8/anim8'
  sti = require 'libraries/Simple-Tiled-Implementation/sti'
  cameraFile = require 'libraries/hump/camera'

  world = wf.newWorld(0, 800, false)

  require('player')

  world:addCollisionClass('Player')

  platforms = {}

  loadMap()
  
end
  
function love.update(dt)
  world:update(dt)
  playerFunctions.playerBasicMovimentation()
end
  
function love.draw()
  world:draw()
end
  
function love.keypressed(key)

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
end

function spawnPlatform(x, y, width, height)
  if width == 0 or height == 0 then
    return
  end

  local platform = world:newRectangleCollider(x, y, width, height, { collision_class = 'Platform' })
  platform:setType('static')
  
  table.insert(platforms, platform)
end