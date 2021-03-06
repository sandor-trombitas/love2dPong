local mt = {}

mt.__index = mt

function mt:update(dt, gameState)
    self.gameState = gameState

    if (self.player1 > 3) then
        GAME_STATE = 'PLAYER 1 WINS'
        self:reset()
    end
    if (self.player2 > 3) then
        GAME_STATE = 'PLAYER 2 WINS'
        self:reset()
    end
end

function mt:reset()
    self.player1 = 0
    self.player2 = 0
end

function mt:updateScore(player)
    self[player] = self[player] + 1
    GAME_STATE = 'START'
end

function mt:draw()
    -- Draw Game State
    love.graphics.setFont(retroFont)
    love.graphics.printf(GAME_STATE, 0, 20, WINDOW_WIDTH, 'center')

    -- Draw Score
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(self.player1), love.graphics.getWidth() / 2 - 200,
        love.graphics.getHeight() / 3)
    love.graphics.print(tostring(self.player2), love.graphics.getWidth() / 2 + 120,
        love.graphics.getHeight() / 3)

    -- Draw FPS
    love.graphics.setFont(retroFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

return {
  new = function(gameState)
    return setmetatable({
        player1 = 0,
        player2 = 0,
        gameState =  gameState
    }, mt)
  end
}
