
Pipe = class{}

local PIPE_IMAGE = love.graphics.newImage('sprites/pipe-green.png')
local scale = 1.7

function Pipe:init(orientation, y)
  self.x = width
  self.y = y
  self.width = PIPE_IMAGE:getWidth() * scale
  self.orientation = orientation
end

function Pipe:update(dt)
end

function Pipe:render()
  love.graphics.draw(
    PIPE_IMAGE, 
    self.x, 
    self.y, 
    0, 
    scale, 
    self.orientation == 'top' and -scale or scale
    )
end