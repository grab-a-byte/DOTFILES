local awful = require('awful')
local apps = require('configuration.apps')

function show_exit_screen()
    _G.exit_screen_show()
end

function lock_the_screen()
    awful.spawn(apps.default.lock)
end

function delayed_screenshot()
    awful.util.spawn_with_shell(apps.default.delayed_screenshot)
end

function screenshot()
    awful.util.spawn_with_shell(apps.default.screenshot)
end

function region_screenshot()
    awful.util.spawn_with_shell(apps.default.region_screenshot)
end

function open_editor()
    awful.util.spawn(apps.default.editor)
end

function open_default_browser()
    awful.util.spawn(apps.default.browser)
end

function open_terminal()
    awful.spawn(apps.default.terminal)
end

function open_system_monitor()
    awful.util.spawn_with_shell(apps.default.system_monitor)
end

function open_file_explorer()
    awful.util.spawn(apps.default.files)
end

function open_lutris()
    awful.util.spawn_with_shell('lutris')
end

function open_default_program_for_tag()
    awful.spawn(
        awful.screen.focused().selected_tag.defaultApp,
        {
            tag = _G.mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
        }
    )
end