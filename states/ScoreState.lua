
ScoreState = class{__includes = BaseState}

function ScoreState:enter(params)
  self.score = params.score
  self.timer = 0
end

function ScoreState:update(dt)
  if self.timer >= 1 then
    if clicked then
      gStateMachine:change('title')
    end
  end
  
  self.timer = self.timer + dt
end

function ScoreState:render()
  love.graphics.setFont(smallFont)
  love.graphics.printf('Oof! You lost!', 0, height/2-40, width, 'center')
  love.graphics.printf('Score: ' .. tostring(self.score), 0, height/2, width, 'center')
  love.graphics.printf('Tap to Play Again!', 0, height/2+40, width, 'center')
end