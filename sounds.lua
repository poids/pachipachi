sfx = {}
bckg = {}

-- background music
-- function bckg.music()
--     bckg = love.audio.newSource( 'assets/sounds/marius_theme.mp3', 'stream' )
--     bckg:setLooping( true ) --so it doesnt stop
--     bckg:setVolume(0.05)
--     bckg:play()
-- end

function sfx.del_ball()
    local del_ball = love.audio.newSource( 'assets/sounds/removeball.ogg', 'static' )
    del_ball:setVolume(0.9)
    del_ball:play()
end

function sfx.add_ball()
    local add_ball = love.audio.newSource( 'assets/sounds/addball.ogg', 'static' )
    add_ball:setVolume(0.1)
    add_ball:play()
end

function sfx.clear_screen()
    local add_ball = love.audio.newSource( 'assets/sounds/clearscreen.ogg', 'static' )
    add_ball:setVolume(1)
    add_ball:play()
end

function sfx.kawfee()
    local kawfee = love.audio.newSource( 'assets/sounds/kawfee.ogg', 'static' )
    kawfee:play()
end