
PipePair = class{}

local PIPE_SCROLL = -60
pipeGap = 250

function PipePair:init(y)
  self.x = width
  self.y = y
  
  self.pipes = {
    ['upper'] = Pipe('top', self.y),
    ['lower'] = Pipe('bottom', self.y + pipeGap)
  }
  
  self.remove = false
  
  self.scored = false
end

function PipePair:update(dt)
  if self.x > -100 then
    self.x = self.x + PIPE_SCROLL*dt
    self.pipes['upper'].x = self.x
    self.pipes['lower'].x = self.x
  else
    self.remove = true
  end
end

function PipePair:render()
  for k, pipe in pairs(self.pipes) do
    pipe:render()
  end
end