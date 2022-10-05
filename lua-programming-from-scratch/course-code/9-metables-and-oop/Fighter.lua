Fighter = {
  name = '',
  health = 0,
  speed = 0
}

function Fighter:light_punch()
  print('Fighter '..self.name.. ' punch')
end

function Fighter:heavy_punch()
  print('Fighter '..self.name.. ' punch')
end

function Fighter:light_kick()
  print('Fighter '..self.name.. ' kick')
end

function Fighter:heavy_kick()
  print('Fighter '..self.name.. ' kick')
end

function Fighter:special_attack()
  print('Fighter '..self.name.. ' special attack')
end

function Fighter:new(t)
  t = t or {}
  setmetatable(t, self)
  self.__index = self
  return t
end