local awful = require('awful')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')

require('functions.clients')
require('functions.programs')
require('functions.utilities')
require('functions.screen_management')
require('functions.window_management')
require('awful.autofocus')


-- Key bindings
local globalKeys =
  awful.util.table.join(
  -- Hotkeys
  awful.key({modkey}, 'h', hotkeys_popup.show_help, {description = 'show help', group = 'awesome'}),
  awful.key({modkey}, 'Escape', show_exit_screen, {description = 'show help', group = 'awesome'}),

  -- Tag browsing
  awful.key({modkey}, 'w', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
  awful.key({modkey}, 's', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
  awful.key({altkey, 'Control'}, 'Up', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
  awful.key({altkey, 'Control'}, 'Down', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
  awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'go back', group = 'tag'}),

  -- Default client focus
  awful.key({modkey}, 'd', focus_next_client, {description = 'focus next by index', group = 'client'}),
  awful.key({modkey}, 'a', focus_previous_client,{description = 'focus previous by index', group = 'client'}),
  awful.key({modkey}, 'r', toggle_panel,{description = 'show main menu', group = 'awesome'}),
  awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'jump to urgent client', group = 'client'}),
  awful.key({altkey}, 'Tab', switch_next_client, {description = 'Switch to next window', group = 'client'}),
  awful.key({altkey, 'Shift'},'Tab', switch_last_client, {description = 'Switch to previous window', group = 'client'}),
  
  -- Programs
  awful.key({modkey}, 'l', lock_the_screen, {description = 'Lock the screen', group = 'awesome'}),
  awful.key({modkey}, 'Print', delayed_screenshot, {description = 'Mark an area and screenshot it 10 seconds later (clipboard)', group = 'screenshots (clipboard)'}),
  awful.key({modkey},'p', screnshot , {description = 'Take a screenshot of your active monitor and copy it to clipboard', group = 'screenshots (clipboard)'}),
  awful.key({altkey, 'Shift'}, 'p', region_screenshot, {description = 'Mark an area and screenshot it to your clipboard', group = 'screenshots (clipboard)'}),
  awful.key({modkey}, 'e', open_editor, {description = 'open a text/code editor', group = 'launcher'}),
  awful.key({modkey},'b', open_default_browser, {description = 'open a browser', group = 'launcher'}),
  awful.key({modkey}, 'Return', open_terminal, {description = 'open a terminal', group = 'launcher'}),
  awful.key({modkey}, 't', open_default_program_for_tag, {description = 'open default program for tag/workspace', group = 'tag'}),
  awful.key({modkey}, 'f', open_file_explorer, {description = 'open default file explorer', group = 'launcher'}),

-- Awesome Controls
  awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
  awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),

-- Window Management
  awful.key({altkey, 'Shift'}, 'Right', increase_master_width_factor, {description = 'increase master width factor', group = 'layout'}),
  awful.key({altkey, 'Shift'}, 'Left', decrease_master_width_factor, {description = 'decrease master width factor', group = 'layout'}),
  awful.key({altkey, 'Shift'}, 'Down', decrease_master_height_factor, {description = 'decrease master height factor', group = 'layout'}),
  awful.key({altkey, 'Shift'}, 'Up', increase_master_height_factor, {description = 'increase master height factor', group = 'layout'}),
  awful.key({modkey, 'Shift'}, 'Left', increase_number_master_clients, {description = 'increase the number of master clients', group = 'layout'}),
  awful.key({modkey, 'Shift'}, 'Right', decrease_number_master_clients, {description = 'decrease the number of master clients', group = 'layout'}),
  awful.key({modkey, 'Control'}, 'Left', increase_number_of_columns, {description = 'increase the number of columns', group = 'layout'}),
  awful.key({modkey, 'Control'}, 'Right', decrease_number_of_columns, {description = 'decrease the number of columns', group = 'layout'}),
  awful.key({modkey},'Space', cycle_next_layout, {description = 'select next', group = 'layout'}),
  awful.key({modkey, 'Shift'}, 'Space', cycle_previous_layout, {description = 'select previous', group = 'layout'}),
  awful.key({modkey, 'Control'}, 'n', restore_minimized, {description = 'restore minimized', group = 'client'}),
  awful.key({modkey}, 'o', awful.client.movetoscreen, {description = 'move window to next screen', group = 'client'}),
  awful.key({ modkey, "Control" }, "j", focus_next_screen, {description = "focus the next screen", group = "screen"}),
  awful.key({ modkey, "Control" }, "k", focus_previous_screen, {description = "focus the previous screen", group = "screen"}),

  -- Dropdown application
  awful.key({modkey},'z', function() _G.toggle_quake() end, {description = 'dropdown application', group = 'launcher'}),
  -- Widgets popups
  --[[awful.key(
    {altkey},
    'h',
    function()
      if beautiful.fs then
        beautiful.fs.show(7)
      end
    end,
    {description = 'show filesystem', group = 'widgets'}
  ),
  awful.key(
    {altkey},
    'w',
    function()
      if beautiful.weather then
        beautiful.weather.show(7)
      end
    end,
    {description = 'show weather', group = 'widgets'}
  ),--]]


  -- Utilities
  awful.key({},'XF86MonBrightnessUp', increase_brightness, {description = '+10%', group = 'hotkeys'}),
  awful.key({},'XF86MonBrightnessDown', decrease_brightness, {description = '-10%', group = 'hotkeys'}),
  awful.key({}, 'XF86AudioRaiseVolume', increase_volume, {description = 'volume up', group = 'hotkeys'}),
  awful.key({},'XF86AudioLowerVolume', decrese_volume, {description = 'volume down', group = 'hotkeys'}),
  awful.key({},'XF86AudioMute', toggle_mute, {description = 'toggle mute', group = 'hotkeys'}),
  awful.key({}, 'XF86PowerOff', show_exit_screen, {description = 'toggle mute', group = 'hotkeys'}),

  -- Custom hotkeys
  awful.key({modkey}, 'g', open_lutris, {description = 'open lutris', group = 'gaming'})
  --awful.key({altKey, modkey}, 'm', open_system_monitor, {description = 'open system monitor', group = 'system'})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = {description = 'view tag #', group = 'tag'}
    descr_toggle = {description = 'toggle tag #', group = 'tag'}
    descr_move = {description = 'move focused client to tag #', group = 'tag'}
    descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
  end
  globalKeys =
    awful.util.table.join(
    globalKeys,
    -- View tag only.
    awful.key(
      {modkey},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view
    ),
    -- Toggle tag display.
    awful.key(
      {modkey, 'Control'},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle
    ),
    -- Move client to tag.
    awful.key(
      {modkey, 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move
    ),
    -- Toggle tag on focused client.
    awful.key(
      {modkey, 'Control', 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:toggle_tag(tag)
          end
        end
      end,
      descr_toggle_focus
    )
  )
end

return globalKeys
