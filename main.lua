start=0
mainValentinOrientation =0
mainValentinOrientationGo=1
fire=0
splosion=0
points=0

enemy_list={}

require "drone"
require "baddrone"

function fillBadGuy()
    for i=1,6 do
        table.insert(enemy_list,BadDrone:new())
        enemy_list[i].x=800-i*10
        enemy_list[i].y=math.random(1,600)
        enemy_list[i].speed=math.random(1,10)/4
    end
    k=BadDrone:new()
    k.positionx=10
    m=BadDrone:new()
    m.positionx=18
    print(tostring(k.positionx))
    for i=1,6 do
        print(tostring(enemy_list[i].y))
    end
end


function love.load()
    currentPlayer=Drone:new()
    splosionimage = love.graphics.newImage("ressources/sprites/splosion.png")
    background  = love.graphics.newImage("ressources/background/container01.jpg")

    love.graphics.setLineWidth( 3 )
    fillBadGuy()
end



function loadframe()
    frames = {}
    table.insert(frames, love.graphics.newImage("jump1.png"))
    table.insert(frames, love.graphics.newImage("jump2.png"))
    table.insert(frames, love.graphics.newImage("jump3.png"))
    table.insert(frames, love.graphics.newImage("jump4.png"))
    table.insert(frames, love.graphics.newImage("jump5.png"))

end


function stage1_update(dt)
    currentPlayer:update()
    if love.mouse.isDown(2) then
        start=1
    end
    if start>0 then
        mainValentinOrientation = mainValentinOrientation + mainValentinOrientationGo*dt
        if math.abs(mainValentinOrientation)>0.05 then
            mainValentinOrientationGo=-mainValentinOrientationGo
        end
        currentPlayer:desaccelerate()

        mouse_x, mouse_y = love.mouse.getPosition()
        if love.mouse.isDown(1) then
            currentPlayer:accelerate(mouse_x, mouse_y)
        end
        
        currentPlayer:move()

        if (love.mouse.isDown(2) and fire==0) then
            fire=20              
            love.graphics.setColor( 1, 0, 0,1 )
            for i=1,6 do
                    if enemy_list[i]:collide(mouse_x,mouse_y) then
                        enemy_list[i].x=780
                        enemy_list[i].y=math.random(1,600)
                        enemy_list[i].speed=math.random(1,10)/4
                        points=points+100
                        splosion=3
                    end
            end
        end

        if fire>0 then
                fire=fire-1
                love.graphics.setColor( 1, 1-fire/20,1-fire/20 ,1 )
        end
        for i=1,6 do
            enemy_list[i].x=enemy_list[i].x-enemy_list[i].speed
        end

    end
end        

function stage1_draw()
    love.graphics.draw(background, 0 , 0, 0, 0.5, 0.6)
    Drone:draw()

    if fire>15 then
       love.graphics.line( currentPlayer.position.x, currentPlayer.position.y, mouse_x, mouse_y)
       love.graphics.line( currentPlayer.position.x, currentPlayer.position.y, mouse_x, mouse_y)
    end

    love.graphics.setColor( 1, 1 ,1,1 )
    for i=1,6 do
       enemy_list[i]:draw2()
    end
    love.graphics.print(tostring(points) , 750, 10)
    if (splosion>0) then
       love.graphics.draw(splosionimage,mouse_x-splosionimage:getWidth()/5, mouse_y-splosionimage:getHeight()/5,0,0.4,0.4)
       splosion=splosion-1
    end
end

c_tbl_draw =
{
  [1] = menu,
  [2] = stage1_draw,
}

c_tbl_update =
{
  [1] = menu,
  [2] = stage1_update,
}

currentState=2

function love.update(dt)
    c_tbl_update[currentState](dt)
end


function love.draw()
    c_tbl_draw[currentState]()
end