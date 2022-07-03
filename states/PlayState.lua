
PlayState = class{__includes = BaseState}

function PlayState:init()
  --Initialize game object
  self.bird = Bird()
  self.pipePairs = {}
  
  --Initialize variables
  self.score = 0
  self.interval = 5
  self.timer = 4
  lastY = math.random(height/5, height*3/4 - pipeGap)
end

function PlayState:update(dt)
  --Bird update
  self.bird:update(dt)
    
  --Timer update
  self.timer = self.timer + dt
    
  --Pipe spawner
  if self.timer > self.interval then
    Y = math.max(height/5, math.min(lastY + math.random(100, -100), height*3/4 - pipeGap))
    lastY = Y
    table.insert(self.pipePairs, PipePair(Y))
    self.timer = 0
    pipeGap = math.max(130, pipeGap - 10)
    self.interval = math.max(2.5, self.interval-0.1)
  end
  
  --Pipe collision detector
  for k, pair in pairs(self.pipePairs) do
    for  l, pipe in pairs(pair.pipes) do
      if self.bird:collides(pipe) then
        gStateMachine:change('score', {
          score = self.score
        })
        sounds['hit']:play()
      end
    end
  end
  
  --Ground collision detector
  if self.bird.y > height-60 then
    gStateMachine:change('score', {
      score = self.score
    })
    sounds['hit']:play()
  end
  
  --Pipe update and score
  for k, pair in pairs(self.pipePairs) do
    if not pair.scored then
      if pair.x + pair.pipes['upper'].width < self.bird.x then
        self.score = self.score + 1
        pair.scored = true
        sounds['point']:play()
      end
    end
    
    pair:update(dt)
  end
  
  --Pipe remover
  for k, pair in pairs(self.pipePairs) do
    if pair.remove then
      table.remove(self.pipePairs, k)
    end
  end
end

function PlayState:render()
  --Draw pipe pairs
  for k, pair in pairs(self.pipePairs) do
    pair:render()
  end
  
  --Draw bird
  self.bird:render()
  
  --Draw score
  love.graphics.printf(self.score, 0, 60, width, 'center')
end