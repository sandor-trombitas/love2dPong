-- Constants

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

PADDLE_SPEED = 200

-- GAME STATE

GAME_STATE = 'START'

-- imports
Paddle = require './Entities/Paddle'
Ball = require './Entities/Ball'
ScoreBoard = require './Entities/ScoreBoard'

local player1 = Paddle.new(20, 80, 'w', 's')
local player2 = Paddle.new(WINDOW_WIDTH - 40, WINDOW_HEIGHT - 180, 'up', 'down')
local scoreBoard = ScoreBoard.new()
local ball = Ball.new(scoreBoard)

local entities = { player1, player2, ball }

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
        if GAME_STATE ~= 'PLAY' then
            GAME_STATE = 'PLAY'
        else
            if GAME_STATE == 'PLAY' then
                GAME_STATE = 'START'
                ball:reset()
            end
        end
    end
end

function love.update(dt)
    for key, value in ipairs(entities) do
        value:update(dt, GAME_STATE)
    end
    scoreBoard:update(dt, GAME_STATE)

    ball:collides(player1)
    ball:collides(player2)
end


function love.draw()
    love.graphics.clear(0.25, 0.1, 0.5, 1)

    scoreBoard:draw()
    for key, value in ipairs(entities) do
        value:draw()
    end
end
