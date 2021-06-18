Drone = {
    position = {x=0,y=0},
    random_move = {x=0,y=0,object_x=0,object_y=0},
    color = nil,
    speed = 0,
    direction = 0,
    sprite=love.graphics.newImage("ressources/sprites/drone.png"),
    gotox=0,
    gotoy=0,
    angle=0
}
    
function Drone:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Drone:update()
 --   if (self.random_move.x==self.random_move.object_x) then
 --       self.random_move.object_x=math.random(10)-5
 --   else
 --       self.random_move.x=self.random_move.x+(self.random_move.object_x-self.random_move.x)/math.abs(self.random_move.object_x-self.random_move.x)/2
 --   end
 --   if (self.random_move.y==self.random_move.object_y) then
 --       self.random_move.object_y=math.random(10)-5
 --   else
 --       self.random_move.y=self.random_move.y+(self.random_move.object_y-self.random_move.y)/math.abs(self.random_move.object_y-self.random_move.y)/2
 --   end 
 --
end


function Drone:move()

    currentPlayerx=self.position.x
    currentPlayery=self.position.y
    sin = math.sin( self.angle)
    cos = math.cos( self.angle)
    self.position.x = self.position.x + self.speed * cos 
    self.position.y = self.position.y + self.speed * sin 
    self.direction = math.atan2(currentPlayery - self.position.y,currentPlayerx -self.position.x)
    vitesse=(math.sqrt(math.abs(self.position.y-self.gotoy)*math.abs(self.position.y-self.gotoy)+math.abs(self.position.x-self.gotox)*math.abs(self.position.x-self.gotox)))/30
    if vitesse<self.speed then
        self.speed=vitesse
    end
end

function Drone:setSpeed(speedvalue)
        self.speed = speedvalue
end

function Drone:accelerate(mouse_x, mouse_y)
    self.gotox=mouse_x
    self.gotoy=mouse_y
    self.angle = math.atan2(mouse_y - currentPlayer.position.y, mouse_x-currentPlayer.position.x)
    vitesse=math.sqrt(math.abs(self.position.y-mouse_y)*math.abs(self.position.y-mouse_y)+math.abs(self.position.x-mouse_x)*math.abs(self.position.x-mouse_x))
    self.speed = vitesse/30
end

function Drone:desaccelerate()

end

function Drone:draw()
    love.graphics.draw(self.sprite, self.position.x+self.random_move.x , self.position.y+self.random_move.y, 0, 1, 1,self.sprite:getWidth()/2,self.sprite:getHeight()/2)
end

return Drone