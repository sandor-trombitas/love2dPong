-- Constants

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

PADDLE_SPEED = 200
GAME_STATE = 'START'

-- imports
Paddle = require './Entities/Paddle'
Ball = require './Entities/Ball'
ScoreBoard = require './Entities/ScoreBoard'

local player1 = Paddle.new(20, 80, 'w', 's')
local player2 = Paddle.new(WINDOW_WIDTH - 40, WINDOW_HEIGHT - 180, 'up', 'down')
local ball = Ball.new()
local scoreBoard = ScoreBoard.new()

local entities = { player1, player2, ball, scoreBoard }

-- Main
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    retroFont = love.graphics.newFont('font.ttf', 32)
    scoreFont = love.graphics.newFont('font.ttf', 128)

    -- Init screen
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = false,
        resizable = false
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'return' then
        if GAME_STATE == 'START' then
            GAME_STATE = 'RUNNING'
        else
            GAME_STATE = 'START'
            ball:reset()
        end
    end
end

function love.update(dt)
    for key, value in ipairs(entities) do
        value:update(dt, GAME_STATE)
    end
end


function love.draw()
    love.graphics.clear(0.25, 0.1, 0.5, 1)

    scoreBoard:draw()

    player1:draw()
    player2:draw()
    ball:draw()
end
