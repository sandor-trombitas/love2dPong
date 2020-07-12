local mt = {}

mt.__index = mt

function mt:update(dt, gameState)
    if (gameState == 'START') then
        return
    end
    self.x = self.x + self.speed.x * dt
    if (self.x > (love.graphics.getWidth() - self.width))
    then
        self.x = love.graphics.getWidth() - self.width
        self.speed.x = self.speed.x * -1
    end

    if (self.x < 0)
    then
        self.x = 0
        self.speed.x = self.speed.x * -1;
    end

    self.y = self.y + self.speed.y * dt
    if (self.y > (love.graphics.getHeight() - self.height))
    then
        self.y = love.graphics.getHeight() - self.height
        self.speed.y = ((self.speed.y / math.abs(self.speed.y)) * -1) * (love.math.random(15, 40) * 10);
    end

    if (self.y < 0)
    then
        self.y = 0
        self.speed.y = ((self.speed.y / math.abs(self.speed.y)) * -1) * (love.math.random(10, 60) * 10);
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
  new = function()
    return setmetatable({
        x = (love.graphics.getWidth() / 2),
        y = love.graphics.getHeight() / 2,
        width = 20,
        height = 20,
        speed = {
            x = 400,
            y = 400
        }
    }, mt)
  end
}
