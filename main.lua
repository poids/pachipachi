require("CircleShape")
require("Bumper")
require("sounds")

-- declare local variables
local balls = {}
local bumpers = {}
local physics = nil

--screen dimensions
width = love.graphics.getWidth()
height = love.graphics.getHeight()

function love.load()
    -- Play start-up sound:
    -- sfx.kawfee()

    -- Physics Engine
    physics = love.physics.newWorld(0, 9.81*64, true)
        physics:setCallbacks(beginContact)

    local floor = {}
    floor.body = love.physics.newBody(
        physics,
        width/2, -- physics is always defined by middle of object by default
        height,
        "static"
    )
    floor.shape = love.physics.newRectangleShape(width, 1) -- 1px high
    floor.fixture = love.physics.newFixture(floor.body, floor.shape)

    -- Bumpers
    local x_bump = {width/10, width*3/10, width*5/10, width*7/10, width*9/10}
    for i, x in ipairs(x_bump) do
        table.insert(bumpers, Bumper.new(x, (height/5), 20, physics, #bumpers + 1)) --#bumbers is index used for callback
        table.insert(bumpers, Bumper.new(x, (height*3/5), 20, physics, #bumpers + 1))
    end

    local x_bump = {0, width/5, width*2/5, width*3/5, width*4/5, width}
    for i, x in ipairs(x_bump) do
        table.insert(bumpers, Bumper.new(x, (height*2/5), 20, physics, #bumpers + 1))
        table.insert(bumpers, Bumper.new(x, (height*4/5), 20, physics, #bumpers + 1))
    end
end

function love.update(dt)
    -- mouse controls
    function love.mousepressed( x, y, button, istouch, presses )
        -- if button == 1 then
        if (button == 1) and (y < height/5) then -- for vaginko
            table.insert(balls, CircleShape.new(x, y, 50, physics))
            sfx.add_ball()
        end
        if (button == 2) and (#balls > 0) then
            table.remove(balls)
            sfx.del_ball()
        end
    end

    --keyboard controls
    if (#balls > 0) then
        if (love.keyboard.isDown('right')) then balls[1]:moveRight() end
        if (love.keyboard.isDown('left')) then balls[1]:moveLeft() end
    end

    --clear balls
    function love.keypressed(key)
        if (key=='space') then
            balls = {}
            sfx.clear_screen()
        end
    end

    physics:update(dt)
end

function love.draw()
    --draw balls
    for i, ball in pairs(balls) do
        ball:draw()
    end

    -- Bumpers
    for i, bumper in pairs(bumpers) do
        life = bumper.life
        if life > 0 then
            bumper:draw(life)
        else
            table.remove(bumpers, i)
        end
    end
end

--CALLBACKS
function beginContact(bumper, ball, coll) --not sure if bumper and ball are always in this order
    local index = bumper:getUserData()
    if bumpers[index] and bumpers[index].life then 
        life = bumpers[index].life
        if (life > 0) then
            bumpers[index].life = life - 1 
        end
    end
    -- print(index, bumpers[index].life)
    -- print(b:getBody())
    -- text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end