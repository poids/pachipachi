CircleShape = {}

-- Graphics
ballsack = love.graphics.newImage("assets/graphics/ballz.png")

CircleShape.new = function(x, y, radius, physics)
    -- this is constructor
    local self = self or {}
    self.x = x
    self.y = y
    self.r = radius
    -- self.p = physics

    --BALL PHYSICS
    self.physics = {}
    self.physics.world = physics
    -- postion of physics object and type (dynamic v. static)
    self.physics.body = love.physics.newBody(self.physics.world, self.x, self.y, "dynamic")
    -- shape/bounding box
    self.physics.shape = love.physics.newCircleShape(self.r)
    -- properties (viscosity, mass, density, flexibility, etc)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape, 1) --1 is defualt density of fixture
    -- make it bounce
    self.physics.fixture:setRestitution(0.9) --1 means no friction or loss of momentum (bounces to same height each time)
    -- set friction
    -- self.physics.fixture:setFriction(0.9)

    --member functions (this draws new instance of circle)
    self.draw = function()
        love.graphics.draw(ballsack,
            self.physics.body:getX(), -- will fall at speed of gravity
            self.physics.body:getY(),
            self.physics.body:getAngle(),
            1, -- this field and one below are just for scale (maybe will be important for dynamic camera)
            1,
            self.r,
            self.r
        )
    end

    -- nudge object left or right
    self.moveLeft = function()
        self.physics.body:applyLinearImpulse(-100,0)
    end
    self.moveRight = function()
        self.physics.body:applyLinearImpulse(100,0)
    end
    
    return self
end