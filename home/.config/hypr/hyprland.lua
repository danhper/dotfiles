-----------------------------
---- VARIABLES ----
-----------------------------

local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show run"
local windowMenu = "rofi -show window"
local browser = "google-chrome-stable --disable-features=WaylandWpColorManagerV1"
local screenshot = "hyprshot -m region --clipboard-only"
local screenshot_window = "hyprshot -m window -m active --clipboard-only"
local email = "mailspring --password-store=gnome-libsecret --ozone-platform=wayland"
local calendar = "morgen"
local locker = "dm-tool lock"
local clipboardHist = "cliphist list | rofi -dmenu -display-columns 2 -p copy | cliphist decode | wl-copy"
local passwordManager = "1password --quick-access"


--------------------
---- Local config ----
--------------------

require("local")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("keyd-application-mapper -d")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Arc'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Arc'")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
end)

-------------------
---- PLUGINS ----
-------------------

hl.config({
    plugin = {
        split_monitor_workspaces = {
            count = 10,
            enable_persistent_workspaces = 1,
        },
    },
})



-----------------------------
---- ENVIRONMENT VARIABLES ----
-----------------------------

hl.env("GTK_THEME", "Arc")

-- Nvidia
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

---------------------
---- LOOK AND FEEL ----
---------------------

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 0,
        border_size = 1,

        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        -- https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 3,
            passes = 1,

            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})


-- https://wiki.hypr.land/Configuring/Variables/#animations

-- Default animations, see https://wiki.hypr.land/Configuring/Animations/ for more

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

-------------
---- INPUT ----
-------------

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        follow_mouse_threshold = 50,
        mouse_refocus = true,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            tap_to_click = false,
            tap_and_drag = false,
            scroll_factor = 0.1,
        },
    },

    cursor = {
        no_warps = true,
    },

    xwayland = {
        force_zero_scaling = true,
        use_nearest_neighbor = true,
    },
})

hl.gesture({ fingers = 3, direction = "right", action = function() hl.exec_cmd("wtype -M alt -k Left -m alt") end })
hl.gesture({ fingers = 3, direction = "left", action = function() hl.exec_cmd("wtype -M alt -k Right -m alt") end })

-------------------
---- KEYBINDINGS ----
-------------------


hl.bind("SUPER_L", hl.dsp.exec_cmd("true"))

hl.bind("CTRL + ALT + t", hl.dsp.exec_cmd(terminal))
hl.bind("CTRL + ALT + f", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + ALT + s", hl.dsp.exec_cmd(screenshot))
hl.bind("CTRL + ALT + SHIFT + s", hl.dsp.exec_cmd(screenshot_window))
hl.bind("CTRL + ALT + m", hl.dsp.exec_cmd(email))
hl.bind("CTRL + ALT + c", hl.dsp.exec_cmd(calendar))
hl.bind("SHIFT + ALT + o", hl.dsp.exec_cmd(windowMenu))
hl.bind("CTRL + SUPER + l", hl.dsp.exec_cmd(locker))
hl.bind("ALT + o", hl.dsp.exec_cmd(menu))
hl.bind("CTRL + ALT + y", hl.dsp.exec_cmd(clipboardHist))
hl.bind("CTRL + SHIFT + space", hl.dsp.exec_cmd(passwordManager))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume '@DEFAULT_SINK@' +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume '@DEFAULT_SINK@' -5%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute '@DEFAULT_SINK@' toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true, locked = true })

hl.bind("SHIFT + ALT + c", hl.dsp.window.close())
hl.bind("ALT + j", hl.dsp.window.cycle_next())
hl.bind("ALT + k", hl.dsp.window.cycle_next({ next = false }))

hl.bind("SHIFT + ALT + j", hl.dsp.window.move({ direction = "d" }))
hl.bind("SHIFT + ALT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind("SHIFT + ALT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind("SHIFT + ALT + l", hl.dsp.window.move({ direction = "r" }))


hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + 1", function() hl.plugin.split_monitor_workspaces.workspace(1) end)
hl.bind("SUPER + 2", function() hl.plugin.split_monitor_workspaces.workspace(2) end)
hl.bind("SUPER + 3", function() hl.plugin.split_monitor_workspaces.workspace(3) end)
hl.bind("SUPER + 4", function() hl.plugin.split_monitor_workspaces.workspace(4) end)
hl.bind("SUPER + 5", function() hl.plugin.split_monitor_workspaces.workspace(5) end)
hl.bind("SUPER + 6", function() hl.plugin.split_monitor_workspaces.workspace(6) end)
hl.bind("SUPER + 7", function() hl.plugin.split_monitor_workspaces.workspace(7) end)
hl.bind("SUPER + 8", function() hl.plugin.split_monitor_workspaces.workspace(8) end)
hl.bind("SUPER + 9", function() hl.plugin.split_monitor_workspaces.workspace(9) end)
hl.bind("SUPER + 0", function() hl.plugin.split_monitor_workspaces.workspace(10) end)

-- move window to workspace N on the focused monitor
hl.bind("SUPER + SHIFT + 1", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(1) end)
hl.bind("SUPER + SHIFT + 2", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(2) end)
hl.bind("SUPER + SHIFT + 3", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(3) end)
hl.bind("SUPER + SHIFT + 4", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(4) end)
hl.bind("SUPER + SHIFT + 5", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(5) end)
hl.bind("SUPER + SHIFT + 6", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(6) end)
hl.bind("SUPER + SHIFT + 7", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(7) end)
hl.bind("SUPER + SHIFT + 8", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(8) end)
hl.bind("SUPER + SHIFT + 9", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(9) end)
hl.bind("SUPER + SHIFT + 0", function() hl.plugin.split_monitor_workspaces.move_to_workspace_silent(10) end)

hl.config({
    binds = {
        drag_threshold = 10, -- Fire a drag event only after dragging for more than 10px
    },
})

hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })


--------------------
---- WINDOW RULES ----
--------------------

-- Ignore maximize requests from apps
hl.window_rule({
    name = "no-maximize-request",
    suppress_event = "maximize",
    match = { class = ".*" },
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-wayland-dragging",
    no_focus = true,
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
})


hl.window_rule({
    name = "no-border-float",
    border_size = 0,
    match = { float = true },
})


hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    name = "full-screen-single-window-1",
    border_size = 0,
    rounding = 0,
    match = {
        float = false,
        workspace = "w[tv1]",
    },
})

hl.window_rule({
    name = "full-screen-single-window-2",
    border_size = 0,
    rounding = 0,
    match = {
        float = false,
        workspace = "f[1]",
    },
})


-- fix tooltips (always have a title of `win.<id>`)
hl.window_rule({
    name = "jetbrains-fix-1",
    no_initial_focus = true,
    no_focus = true,
    match = {
        class = "^(.*jetbrains.*)$",
        title = "^(win.*)$",
    },
})

-- fix tab dragging (always have a single space character as their title)
hl.window_rule({
    name = "jetbrains-fix-2",
    no_initial_focus = true,
    no_focus = true,
    match = {
        class = "^(.*jetbrains.*)$",
        title = [[^\s$]],
    },
})

hl.window_rule({
    name = "jetbrains-fix-3",
    focus_on_activate = true,
    match = { class = "^jetbrains-(?!toolbox)" },
})
