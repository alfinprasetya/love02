
TitlescreenState = class{__includes = BaseState}

local MSG_IMAGE = love.graphics.newImage('sprites/message.png')
local scale = 1.2
local msgWidth = MSG_IMAGE:getWidth() * scale
local msgHeight = MSG_IMAGE:getHeight() * scale

function TitlescreenState:init()
  self.timer = 0
end

function TitlescreenState:update(dt)
  if self.timer >= 1 then
    if clicked then
      gStateMachine:change('play')
    end
  end
  
  self.timer = self.timer + dt
end

function TitlescreenState:render()
  love.graphics.draw(MSG_IMAGE,
    (width - msgWidth)/2,
    (height - msgHeight)/2,
    0,
    scale,
    scale
    )
end