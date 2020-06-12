-- "callback" love calls this before everything loads
function love.conf(t)
    t.window.title = "Sweaty Balls"
    t.window.width = 1024
    t.window.height = 720

    t.console = true -- this is already turned on in lua extension settings

    t.modules.touch = false --turns off touch module for mobile to save space
    t.window.fullscreen = true

    t.vsync = true --synchronizes draw rate to monitor refresh rate (default true)

    -- set app icon
    -- t.window.icon = "birthdaycake.png"
end