function love.load()
  love.window.setMode(1000, 768)

  anim8 = require 'libraries/anim8/anim8'
  sti = require 'libraries/Simple-Tiled-Implementation/sti'

  sprites = {}
  sprites.playerSheet = love.graphics.newImage('sprites/playerSheet.png')

  local grid = anim8.newGrid(614, 564, sprites
    .playerSheet:getWidth(), sprites.playerSheet:getHeight())

  animations = {}
  animations.idle = anim8.newAnimation(grid('1-15', 1), 0.05)
  animations.jump = anim8.newAnimation(grid('1-7', 2), 0.05)
  animations.run = anim8.newAnimation(grid('1-15', 3), 0.05)

  wf = require 'libraries/windfield/windfield'
  world = wf.newWorld(0, 800, false)

  world:addCollisionClass('Platform')
  world:addCollisionClass('Player')
  world:addCollisionClass('Danger')

  require('player')


  platform = world:newRectangleCollider(250, 400, 300, 100, { collision_class = 'Platform' })
  platform:setType('static')

  dangerZone = world:newRectangleCollider(0, 550, 800, 50, { collision_class = 'Danger' })
  dangerZone:setType('static')

  loadMap()
end

function love.update(dt)
  world:update(dt)
  gameMap:update(dt)

  PlayerTable.playerIdleMovimentation()
  PlayerTable.playerRunningMovimentation()
  PlayerTable.playerPerishesWhenEnteringDangerZone()
  PlayerTable.playerJumpingMovimentation()
  destroyAreaOnClicking()
  PlayerTable.playerChangeAnimation()

  player.animation:update(dt)
end

function love.draw()
  gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
  world:draw()

  PlayerTable.drawPlayer()
end

function loadMap()
  gameMap = sti("maps/level1.lua")
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