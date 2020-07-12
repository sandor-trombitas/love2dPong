local mt = {}

mt.__index = mt

function mt:bounce(axis, wall)
    self[axis] = wall
    if axis == 'x' then
        self.speed[axis] = self.speed[axis] * -1
    else
        self.speed[axis] = ((self.speed[axis] / math.abs(self.speed[axis])) * -1) * (love.math.random(250, math.abs(self.speed[axis])))
    end

    print(self.speed.x, self.speed.y)
end

function mt:collides(paddle)
    if (self.x > paddle.x + paddle.width or paddle.x > self.x + self.width) then
        return
    end

    if (self.y > paddle.y + paddle.height or paddle.y > self.y + self.height) then
        return
    end

    self:bounce('x', self.speed.x > 0 and (paddle.x - self.width) or paddle.x + paddle.width)
    sounds.paddle_hit:play()
end

function mt:update(dt, gameState)
    if (gameState ~= 'PLAY') then
        return
    end
    self.x = self.x + self.speed.x * dt
    if (self.x > (love.graphics.getWidth() - self.width))
    then
        self.scoreBoard:updateScore('player1')
        sounds.score:play()
        self:reset()
    end

    if (self.x < 0)
    then
        self.scoreBoard:updateScore('player2')
        sounds.score:play()
        self:reset()
    end

    self.y = self.y + self.speed.y * dt
    if (self.y > (love.graphics.getHeight() - self.height))
    then
        self:bounce('y', love.graphics.getHeight() - self.height)
        sounds.wall_hit:play()
    end

    if (self.y <= 0)
    then
        self:bounce('y', 0)
        sounds.wall_hit:play()
    end

end

function mt:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function mt:reset()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.speed.x = love.math.random(-1, 1) > 0 and 400 or -400
    self.speed.y = love.math.random(15, 40) * 10 * (love.math.random(-1, 1) > 0 and 1 or -1)
end

return {
  new = function(scoreBoard, sounds)
    return setmetatable({
        x = WINDOW_WIDTH / 2,
        y = WINDOW_HEIGHT / 2,
        width = 20,
        height = 20,
        speed = {
            x = 400,
            y = 400
        },
        scoreBoard = scoreBoard,
        sounds = sounds
    }, mt)
  end
}
