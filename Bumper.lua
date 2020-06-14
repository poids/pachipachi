Bumper = {}

-- Graphics
bumpgreen = love.graphics.newImage("assets/graphics/bumper_green.png")
bumpyellow = love.graphics.newImage("assets/graphics/bumper_yellow.png")
bumpred = love.graphics.newImage("assets/graphics/bumper_red.png")

--Bumper class will load at start of game from table of x,y coordinates
Bumper.new = function(x, y, radius, physics)
    --constructor
    local self = self or {}
    self.x = x
    self.y = y
    self.r = radius

    -- PHYSICS
    self.p = {}
    self.p.world = physics
    -- body - static object
    self.p.body = love.physics.newBody(self.p.world, self.x, self.y, "static")
    -- shape/bounding box
    self.p.shape = love.physics.newCircleShape(self.r)
    -- properties
    self.p.fixture = love.physics.newFixture(self.p.body, self.p.shape, 1) --density
    self.p.fixture:setRestitution(0.9)
    self.p.fixture:setFriction(0.3) -- friction

    --member functions (this draws new instance of circle)
    self.draw = function()
        -- love.graphics.setColor(255,0,0)
        love.graphics.draw(
            bumpboy,
            self.x, -- will fall at speed of gravity
            self.y,
            1,
            1,
            1,
            self.r,
            self.r
        )
        -- love.graphics.setColor(255,255,255)
    end

    return self
end