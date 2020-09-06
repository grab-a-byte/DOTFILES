local awful = require('awful')

function increase_master_width_factor()
    awful.tag.incmwfact(0.05)
end

function decrease_master_width_factor()
    awful.tag.incmwfact(-0.05)
end

function decrease_master_height_factor()
    awful.client.incwfact(0.05)
end

function increase_master_height_factor()
    awful.client.incwfact(-0.05)
end

function increase_number_master_clients()
    awful.tag.incnmaster(1, nil, true)
end

function decrease_number_master_clients()
    awful.tag.incnmaster(-1, nil, true)
end

function increase_number_of_columns()
    awful.tag.incncol(1, nil, true)    
end

function decrease_number_of_columns()
    awful.tag.incncol(-1, nil, true)    
end

function cycle_next_layout()
    awful.layout.inc(1)
end

function cycle_previous_layout()
    awful.layout.inc(-1)
end

function restore_minimized()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      _G.client.focus = c
      c:raise()
    end
end