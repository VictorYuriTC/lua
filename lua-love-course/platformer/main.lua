function love.load()
  love.window.setMode(1000, 768)

  wf = require 'libraries/windfield/windfield'
  anim8 = require 'libraries/anim8/anim8'
  sti = require 'libraries/Simple-Tiled-Implementation/sti'
  cameraFile = require 'libraries/hump/camera'
  
  cam = cameraFile()

  sounds = {}
  sounds.jump = love.audio.newSource('audio/jump.wav', "static")
  sounds.music = love.audio.newSource('audio/music.mp3', "stream")
  sounds.music:setLooping(true)
  sounds.music:setVolume(0.3)

  sounds.music:play()

  sprites = {}
  sprites.playerSheet = love.graphics.newImage('sprites/playerSheet.png')
  sprites.enemySheet = love.graphics.newImage('sprites/enemySheet.png')
  sprites.background = love.graphics.newImage('sprites/background.png')

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
  require('libraries/show')

  dangerZone = world:newRectangleCollider(-500, 800, 5000, 50, { collision_class = 'Danger' })
  dangerZone:setType('static')
  
  platforms = {}

  flagX = 0
  flagY = 0

  saveData = {}
  saveData.currentLevel = 'level1'

  if love.filesystem.getInfo('data.lua') then
    local data = love.filesystem.load('data.lua')
    data()
  end

  loadMap(saveData.currentLevel)
end

function love.update(dt)
  world:update(dt)
  gameMap:update(dt)

  PlayerTable.playerIdleMovimentation()
  PlayerTable.playerRunningMovimentation()
  PlayerTable.playerPerishesWhenEnteringDangerZone()
  PlayerTable.playerChangeAnimation()
  PlayerTable.playerAnimationUpdate(dt)

  updateEnemies(dt)

  destroyAreaOnClicking()
  makeCameraVisionFollowPlayer()
  switchMapLevelWhenReachingTheFlag()
end

function love.draw()
  love.graphics.draw(sprites.background, 0, 0)
  cam:attach()
  drawEnemies()
    gameMap:drawLayer(gameMap.layers["Tile Layer 1"])

    PlayerTable.drawPlayer()
  cam:detach()
end


function love.keypressed(key)
  if not PlayerTable.isPlayerAlive() then
    return
  end

  local colliders = world:queryRectangleArea(player:getX() - 20, player:getY() + 50, 40, 2, {'Platform'})

  if key == 'up' or key == 'space' then
    if #colliders > 0 then
      player:applyLinearImpulse(0, -4000)
      sounds.jump:play()
      player.isJumping = true
    end
  end

  if #colliders == 0 then
    player.isJumping = true
  end
end

function loadMap(mapName)
  saveData.currentLevel = mapName
  love.filesystem.write('data.lua', table.show(saveData, "saveData"))

  destroyAllPlatforms()
  destroyAllEnemies()


  gameMap = sti("maps/" .. mapName .. ".lua")

  for i, startPoint in pairs(gameMap.layers["Start"].objects) do
    playerStartX = startPoint.x
    playerStartY = startPoint.y
  end

  player:setPosition(playerStartX, playerStartY)

  for i, platform in pairs(gameMap.layers["Platforms"].objects) do
    spawnPlatform(platform.x, platform.y, platform.width, platform.height)
  end

  for i, enemy in pairs(gameMap.layers["Enemies"].objects) do
    spawnEnemy(enemy.x, enemy.y, enemy.width, enemy.height)
  end

  for i, flag in pairs(gameMap.layers["Flags"].objects) do
    flagX = flag.x
    flagY = flag.y
  end
end


function switchMapLevelWhenReachingTheFlag()
  local colliders = world:queryCircleArea(flagX, flagY, 10, {'Player'})

  if #colliders > 0 then
    if saveData.currentLevel == 'level1' then
      loadMap('level2')
    elseif saveData.currentLevel == 'level2' then
      loadMap('level1')
    end
  end
end

function destroyAllPlatforms()
  local i = #platforms
  while i > -1 do
    if platforms[i] ~= nil then
      platforms[i]:destroy()
    end

    table.remove(platforms, i)
    i = i - 1
  end

end

function destroyAllEnemies()
  local i = #enemies
  while i > -1 do
    if enemies[i] ~= nil then
      enemies[i]:destroy()
    end

    table.remove(enemies, i)
    i = i - 1
  end
end

function makeCameraVisionFollowPlayer()
  if not PlayerTable.isPlayerAlive() then
    return
  end

  local px, py = player:getPosition()
  cam:lookAt(px, love.graphics.getHeight() / 2)
end

function spawnPlatform(x, y, width, height)
  if width == 0 or height == 0 then
    return
  end

  local platform = world:newRectangleCollider(x, y, width, height, { collision_class = 'Platform' })
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