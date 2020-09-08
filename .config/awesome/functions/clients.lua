local awful = require('awful')

function focus_next_client()
    awful.client.focus.byidx(1)
end

function focus_previous_client()
    awful.client.focus.byidx(-1)
end

function toggle_panel()
    _G.screen.primary.left_panel:toggle(true)
end

function switch_next_client()
    awful.client.focus.byidx(1)
    if _G.client.focus then
      _G.client.focus:raise()
    end
end

function switch_last_client()
    awful.client.focus.byidx(-1)
    if _G.client.focus then
      _G.client.focus:raise()
    end
end

function swap_with_previous_client()
    awful.client.swap.byidx(-1)
end

function swap_with_next_client()
    awful.client.swap.byidx(1)
end
    