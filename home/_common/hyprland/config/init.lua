-- Minimal host-agnostic Hyprland Lua config loaded out-of-store.

--
-- ========== Variables ==========
--
local mod = "SUPER"
local terminal = "kitty"
local fileManager = "nautilus"

--
-- ========== Environment ==========
--
hl.config({
    monitor = {
        "Virtual-1, highres, 0x0, 1",
    },
    env = {
        "QT_QPA_PLATFORMTHEME,qt5ct",
        "MOZ_ENABLE_WAYLAND,1",
        "MOZ_WEBRENDER,1",
        "XDG_SESSION_TYPE,wayland",
        "WLR_NO_HARDWARE_CURSORS,1",
        "WLR_RENDERER_ALLOW_SOFTWARE,1",
        "QT_QPA_PLATFORM,wayland",
    },
})

--
-- ========== Behavior & Appearance ==========
--
hl.config({
    binds = {
        workspace_center_on = 1,
        movefocus_cycles_fullscreen = false,
    },
    input = {
        kb_layout = "ro,ru",
        kb_options = "grp:alt_shift_toggle,lv3:ralt_switch",
        natural_scroll = false,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = false,
        },
    },
    cursor = {
        inactive_timeout = 10,
    },
    misc = {
        disable_hyprland_logo = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        middle_click_paste = false,
    },
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 1,
        allow_tearing = true,
        resize_on_border = true,
        hover_icon_on_border = true,
    },
    decoration = {
        rounding = 8,
        active_opacity = 1.0,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1.0,
        blur = {
            enabled = true,
            size = 4,
            passes = 2,
            new_optimizations = true,
            popups = true,
        },
        shadow = {
            enabled = true,
        },
    },
    animations = {
        enabled = true,
        bezier = { "myBezier, 0.05, 0.9, 0.1, 1.05" },
        animation = {
            "windows, 1, 7, myBezier",
            "windowsOut, 1, 7, default, popin 80%",
            "border, 1, 10, default",
            "borderangle, 1, 8, default",
            "fade, 1, 7, default",
            "workspaces, 1, 6, default",
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

--
-- ========== Core Binds — App Launch & Window Ops ==========
--
hl.bind(mod .. " + B", hl.dsp.exec_cmd("app.zen_browser.zen"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

-- Move Focus
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Special Workspace
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Chained / Sequential Binds
hl.bind(mod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(mod .. " + ALT + F", hl.dsp.window.fullscreen({ action = "toggle" }))

--
-- ========== Workspace Switching ==========
--
-- Mouse Scroll & Directional
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + Control_L + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + Control_L + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))

-- Number keys — maps 1→code:10, 9→code:18, 10→code:19 (the 0 key)
for i = 1, 10 do
    local ws = tostring(i)
    local keycode = "code:" .. tostring(9 + i)
    hl.bind(mod .. " + " .. keycode, hl.dsp.focus({ workspace = ws }))
    hl.bind(mod .. " + SHIFT + " .. keycode, hl.dsp.window.move({ workspace = ws }))
end
