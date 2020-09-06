local awful = require('awful')

function increase_brightness()
    awful.spawn('xbacklight -inc 10')
end

function decrease_brightness()
    awful.spawn('xbacklight -dec 10')
end

function increase_volume()
    awful.spawn('amixer -D pulse sset Master 5%+')
end

function decrese_volume()
    awful.spawn('amixer -D pulse sset Master 5%-')
end

function toggle_mute()
    awful.spawn('amixer -D pulse set Master 1+ toggle')
end