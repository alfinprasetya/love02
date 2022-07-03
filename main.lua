--[[
    Project Metadata
    No          : 2
    Name        : Flappy Bird
    Author      : Alfin Prasetya
    Start Date  : 19 May 2022
    Finish Date : 11 Juni 2022
]]

-- Include library
class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitlescreenState'
require 'states/ScoreState'

--Load image file 
  local background = love.graphics.newImage('sprites/background-day.png')
  local backgroundScroll = 0
  
  local base = love.graphics.newImage('sprites/base.png')
  local baseScroll = 0
  
--Set constant variables
  local BACKGROUND_SPEED = 30
  local BASE_SPEED = 60
  GRAVITY = 20

--Load function
function love.load()
  --Set retro filter
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  --App title
  love.window.setTitle('Flappy bird')
  
  --Random generator
  math.randomseed(os.time())
  
  --Initialize font
  Font = love.graphics.newFont('Font.ttf', 64)
  smallFont = love.graphics.newFont('Font.ttf', 32)
  
  --Initialize game sound
  sounds = {
    ['hit'] = love.audio.newSource('audio/hit.ogg', 'static'),
    ['point'] = love.audio.newSource('audio/point.ogg', 'static'),
    ['wing'] = love.audio.newSource('audio/wing.ogg', 'static')
  }
  
  --Initialize game window
  width = love.graphics.getHeight() + 25
  height = love.graphics.getWidth() + 25
  love.window.setMode(width, height)
  
  --Initialize state machine
  gStateMachine = StateMachine {
    ['title'] = function() return TitlescreenState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end
  }
  gStateMachine:change('title')
  
  --Variable to detect mouse click
  clicked = false
end

--Mouse function
function love.mousepressed()
  clicked = true
end

--Update function
function love.update(dt)
  --Parallax calculations
  backgroundScroll = (backgroundScroll + BACKGROUND_SPEED *dt) % width
  baseScroll = (baseScroll + BASE_SPEED *dt) % width
  
  --Update behavior based on current state
  gStateMachine:update(dt)
  
  --Reset touch variable
  clicked = false
end

--Draw function
function love.draw()
  
  love.graphics.setFont(Font)
  
  --Draw background
  local background_sx = width / background:getWidth()
  local background_sy = height / background:getHeight()
  love.graphics.draw(background, -backgroundScroll, 0, 0, background_sx, background_sy)
  love.graphics.draw(background, width-backgroundScroll, 0, 0, background_sx, background_sy)
  
  --Draw object based on current state
  gStateMachine:render()
  
  --Draw base
  local base_sx = width / base:getWidth()
  love.graphics.draw(base, -baseScroll, (height+60) - base:getHeight(), 0, base_sx)
  love.graphics.draw(base, width-baseScroll, (height+60) - base:getHeight(), 0, base_sx)
end