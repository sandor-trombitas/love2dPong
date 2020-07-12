local mt = {}

mt.__index = mt

function mt:update(dt)
  if love.keyboard.isDown(self.up) then
    self.y = math.max(0, self.y - dt * self.speed)
  end
  if love.keyboard.isDown(self.down) then
    self.y = math.min(love.graphics.getHeight() - self.height, self.y + dt * self.speed)
  end
end

function mt:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return {
  new = function(x, y, up, down)
    return setmetatable({
      x = x,
      y = y,
      up = up,
      down = down,
      width = 20,
      height = 80,
      speed = 800
    }, mt)
  end
}
