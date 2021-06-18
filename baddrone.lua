BadDrone = {
    x=0,
    y=0,
    color = nil,
    speed = 0,
    direction = 0,
    sprite=love.graphics.newImage("ressources/sprites/Drone2.png")
}
    
function BadDrone:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.width=self.sprite:getWidth()
    self.height=self.sprite:getHeight()
    self.random_move = {x=0,y=0,object_x=0,object_y=0}
    return o
end

function BadDrone:update()
    if (self.random_move.x==self.random_move.object_x) then
        self.random_move.object_x=math.random(10)-5
    else
        self.random_move.x=self.random_move.x+(self.random_move.object_x-self.random_move.x)/math.abs(self.random_move.object_x-self.random_move.x)/2
    end
    if (self.random_move.y==self.random_move.object_y) then
        self.random_move.object_y=math.random(10)-5
    else
        self.random_move.y=self.random_move.y+(self.random_move.object_y-self.random_move.y)/math.abs(self.random_move.object_y-self.random_move.y)/2
    end
end


function BadDrone:move(angle)
    sin = math.sin(angle)
    cos = math.cos(angle)
    self.x = self.x + self.speed * cos
    self.y = self.y + self.speed * sin
end

function BadDrone:setSpeed(speedvalue)
    self.speed = speedvalue
end

function BadDrone:accelerate()
    self.speed = self.speed+10
end

function BadDrone:desaccelerate()
    if speed>0 then
        self.speed = self.speed-10
    else
        self.speed = 0
    end
end

function BadDrone:draw2()
    love.graphics.draw(self.sprite, self.x, self.y+self.random_move.y, 0, 1, 1,self.sprite:getWidth()/2,self.sprite:getHeight()/2)
    --love.graphics.rectangle( "fill", self.x, self.y, self.width/2, self.height/2)
end

function BadDrone:collide(positionx,positiony)
    local position={x=positionx,y=positiony}
    if (position.x>self.x-self.width/2 and position.x<self.x+self.width/2 and position.y>self.y-self.height/2 and position.y<self.y+self.height/2) then
        return true
    else
        return false
    end

end