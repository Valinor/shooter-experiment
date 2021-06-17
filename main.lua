start=0
mainValentinOrientation =0
mainValentinOrientationGo=1
fire=0
splosion=0
points=0

badguyArrayX={}
badguyArrayY={}
badguyArraySpeed={}

function fillBadGuy()
for i=1,6 do
	table.insert(badguyArrayX,800)   
	table.insert(badguyArrayY,math.random(1,600))
	table.insert(badguyArraySpeed,math.random(1,10)/4)
end
end


function love.load()
    myImage = love.graphics.newImage("ressources/sprites/drone.png")
    BadGuy = love.graphics.newImage("ressources/sprites/Drone2.png")
    splosionimage = love.graphics.newImage("ressources/sprites/splosion.png")
    background  = love.graphics.newImage("ressources/background/container01.jpg")
    width = myImage:getWidth()
    height = myImage:getHeight()
    myImagex=100
    myImagey=300
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

function love.update(dt)
if love.mouse.isDown(2) then
start=1
end
    if start>0 then
    mainValentinOrientation = mainValentinOrientation + mainValentinOrientationGo*dt
    if math.abs(mainValentinOrientation)>0.05 then
	mainValentinOrientationGo=-mainValentinOrientationGo
    end

    mouse_x, mouse_y = love.mouse.getPosition()
    if love.mouse.isDown(1) then
	    angle = math.atan2(mouse_y - myImagey, mouse_x - myImagex)
	    cos = math.cos(angle)
	    sin = math.sin(angle)
	    myImagex = myImagex + 100* cos * dt
	    myImagey = myImagey + 100 * sin * dt
    end

    if (love.mouse.isDown(2) and fire==0) then
	fire=20              
	love.graphics.setColor( 1, 0, 0,1 )
for i=1,6 do
        if (mouse_x>(badguyArrayX[i]) and mouse_x<(badguyArrayX[i]+BadGuy:getWidth()/2) and mouse_y>(badguyArrayY[i]) and mouse_y<(badguyArrayY[i]+BadGuy:getHeight()/2)) then
          badguyArrayX[i]=780
          badguyArrayY[i]=math.random(1,600)
	  badguyArraySpeed[i]=math.random(1,10)/4
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
       badguyArrayX[i]=badguyArrayX[i]-badguyArraySpeed[i]
    end

end
end

function love.draw()
    love.graphics.draw(background, 0 , 0, 0, 0.5, 0.6)
    love.graphics.draw(myImage, myImagex , myImagey, mainValentinOrientation, 0.5, 0.5, width/2, height/2)

    if fire>15 then
       love.graphics.line( myImagex+15, myImagey, mouse_x, mouse_y)
       love.graphics.line( myImagex-15, myImagey, mouse_x, mouse_y)
    end

    love.graphics.setColor( 1, 1 ,1,1 )
    for i=1,6 do
       --love.graphics.rectangle("fill", badguyArrayX[i], badguyArrayY[i],BadGuy:getWidth()/2, BadGuy:getHeight()/2 )
       love.graphics.draw(BadGuy, badguyArrayX[i] , badguyArrayY[i], 0,0.5,0.5)
    end
    love.graphics.print(tostring(points) , 750, 10)
    if (splosion>0) then
       love.graphics.draw(splosionimage,mouse_x-splosionimage:getWidth()/5, mouse_y-splosionimage:getHeight()/5,0,0.4,0.4)
       splosion=splosion-1
    end
end