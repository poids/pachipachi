require("CircleShape")
require("sounds")

-- declare local variables
local balls = {}
local physics = nil

--screen dimensions
width = love.graphics.getWidth()
height = love.graphics.getHeight()

function love.load()
    -- Play start-up sound:
    sfx.kawfee()

    -- Physics Engine
    physics = love.physics.newWorld(0, 9.81*64, true)

    local floor = {}
    floor.body = love.physics.newBody(
        physics,
        width/2, -- physics is always defined by middle of object by default
        height,
        "static"
    )
    floor.shape = love.physics.newRectangleShape(width, 1) -- 1px high
    floor.fixture = love.physics.newFixture(floor.body, floor.shape)
end

function love.update(dt)
    -- mouse controls
    function love.mousepressed( x, y, button, istouch, presses )
        -- if button == 1 then
        if (button == 1) and (y < height/3) then -- for vaginko
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
end
