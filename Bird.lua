
Bird = class{}

local offset = 5
local scale = 1.7

function Bird:init()
  self.image = love.graphics.newImage('sprites/bluebird-midflap.png')
  self.imageUp = love.graphics.newImage('sprites/bluebird-downflap.png')
  self.imageDown = love.graphics.newImage('sprites/bluebird-upflap.png')
  self.sprite = self.image
  self.width = self.image:getWidth() * scale
  self.height = self.image:getHeight() * scale
  
  self.x = (width / 5) - (self.width / 2)
  self.y = (height / 2) - (self.height / 2)
  
  self.Dy = 0
end

function Bird:update(dt)
  self.Dy = self.Dy + GRAVITY * dt
  self.y = self.y + self.Dy 
  
  if clicked then
    self.Dy = -5
    sounds['wing']:play()
  end
  
  if self.Dy > 1 then
    self.sprite = self.imageDown
  elseif self.Dy < -1 then
    self.sprite = self.imageUp
  else
    self.sprite = self.image
  end
end

function Bird:collides(pipe)
  if self.x + offset >= pipe.x 
    and self.x + offset <= pipe.x + pipe.width 
    or self.x + self.width - offset >= pipe.x 
    and self.x + self.width - offset <= pipe.x + pipe.width
    then
    if pipe.orientation == 'top' then
      if self.y + offset <= pipe.y then
        return true
      end
    else
      if self.y + self.height - offset >= pipe.y then
        return true
      end
    end
  end
  
  return false
end

function Bird:render()
  love.graphics.draw(self.sprite, self.x, self.y, 0, scale, scale)
end