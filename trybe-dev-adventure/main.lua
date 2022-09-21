function love.load()
  wf = require 'libraries/windfield/windfield'
  anim8 = require 'libraries/anim8/anim8'
  sti = require 'libraries/Simple-Tiled-Implementation/sti'
  cameraFile = require 'libraries/hump/camera'

  world = wf.newWorld(0, 800, false)

  require('player')

  world:addCollisionClass('Player')

  platforms = {}

  
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