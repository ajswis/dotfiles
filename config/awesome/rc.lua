local gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
naughty = require("naughty")
require("obvious.battery")
require("obvious.volume_alsa")
local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end
tagone = tag({ name = 'one' })
tagone.screen = 1
tagone.selected = true

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, an error happened!",
    text = err })
    in_error = false
  end)
end
-- }}}

awful.util.spawn('compton')
awful.util.spawn_with_shell('killall conky 2>/dev/null 1>&2; conky -c ' .. os.getenv('HOME') .. '/.config/conky/conkyrc')
awful.util.spawn('pidgin')

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

s_mod = "Mod4"
alt_mod = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
  awful.layout.suit.tile.left,
  awful.layout.suit.tile,
  --awful.layout.suit.tile.bottom,
  --awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  --awful.layout.suit.fair.horizontal,
  --awful.layout.suit.spiral,
  --awful.layout.suit.spiral.dwindle,
  --awful.layout.suit.max,
  --awful.layout.suit.max.fullscreen,
  --awful.layout.suit.magnifier,
  awful.layout.suit.floating,
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
  -- Each screen has its own tag table.
  tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
awesomemenu = {
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}

mainmenu = awful.menu({ items = {
  { "awesome", awesomemenu, beautiful.awesome_icon },
  { "open terminal", terminal }
}})

launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
textclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
widgetbox = {}
promptbox = {}
layoutbox = {}
taglist = {}
taglist.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ s_mod }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ s_mod }, 3, awful.client.toggletag),
  awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
tasklist = {}
tasklist.buttons = awful.util.table.join(
  awful.button({ }, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({
        theme = { width = 250 }
      })
    end
  end),
  awful.button({ }, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)


for s = 1, screen.count() do
  -- Create a promptbox for each screen
  promptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  layoutbox[s] = awful.widget.layoutbox(s)
  layoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function() awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function() awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function() awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function() awful.layout.inc(layouts, -1) end))
  )
  -- Create a taglist widget
  taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist.buttons)

  -- Create a tasklist widget
  tasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist.buttons)

  -- Create the wibox
  widgetbox[s] = awful.wibox({ position = "top", screen = s })

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(launcher)
  left_layout:add(taglist[s])
  left_layout:add(promptbox[s])

  -- Widgets that are aligned to the right
  local right_layout = wibox.layout.fixed.horizontal()
  local seperator = wibox.widget.textbox()
  seperator:set_text(' | ')
  if s == 1 then right_layout:add(wibox.widget.systray()) end
  right_layout:add(textclock)
  right_layout:add(seperator)
  right_layout:add(obvious.volume_alsa(1, "Master"))
  right_layout:add(seperator)
  right_layout:add(obvious.battery())
  right_layout:add(seperator)
  right_layout:add(layoutbox[s])

  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_middle(tasklist[s])
  layout:set_right(right_layout)

  widgetbox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
  awful.button({ }, 3, function() mainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
  awful.key({ s_mod,           }, "Left",   awful.tag.viewprev       ),
  awful.key({ s_mod,           }, "Right",  awful.tag.viewnext       ),
  awful.key({ s_mod,           }, "Escape", awful.tag.history.restore),

  awful.key({ s_mod,           }, "j", function()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ s_mod,           }, "k", function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ s_mod,           }, "Space", function() mainmenu:show() end),

  -- Layout manipulation
  awful.key({ s_mod, "Shift"   }, "j", function() awful.client.swap.byidx(  1)    end),
  awful.key({ s_mod, "Shift"   }, "k", function() awful.client.swap.byidx( -1)    end),
  awful.key({ s_mod, "Control" }, "j", function() awful.screen.focus_relative( 1) end),
  awful.key({ s_mod, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
  awful.key({ s_mod,           }, "u", awful.client.urgent.jumpto),
  awful.key({ alt_mod,         }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end),

  -- Standard program
  awful.key({ s_mod, "Control" }, "r", awesome.restart),
  awful.key({ s_mod, "Shift"   }, "q", awesome.quit),

  awful.key({ s_mod,           }, "l",     function() awful.tag.incmwfact( 0.05)    end),
  awful.key({ s_mod,           }, "h",     function() awful.tag.incmwfact(-0.05)    end),
  awful.key({ s_mod, "Shift"   }, "h",     function() awful.tag.incnmaster( 1)      end),
  awful.key({ s_mod, "Shift"   }, "l",     function() awful.tag.incnmaster(-1)      end),
  awful.key({ s_mod, "Control" }, "h",     function() awful.tag.incncol( 1)         end),
  awful.key({ s_mod, "Control" }, "l",     function() awful.tag.incncol(-1)         end),
  awful.key({ s_mod,           }, "space", function() awful.layout.inc(layouts,  1) end),
  awful.key({ s_mod, "Shift"   }, "space", function() awful.layout.inc(layouts, -1) end),
  awful.key({ s_mod, "Control" }, "n", awful.client.restore),

  -- Prompt
  awful.key({ s_mod },            "r",     function() promptbox[mouse.screen]:run() end),
  awful.key({ s_mod },            "x",     function()
    awful.prompt.run({ prompt = "Run Lua code: " },
    mypromptbox[mouse.screen].widget,
    awful.util.eval, nil,
    awful.util.getdir("cache") .. "/history_eval")
  end),
  -- Menubar
  awful.key({ s_mod }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
  awful.key({ s_mod,           }, "f",      function(c) c.fullscreen = not c.fullscreen  end),
  awful.key({ s_mod, "Shift"   }, "c",      function(c) c:kill()                         end),
  awful.key({ s_mod, "Control" }, "space",  awful.client.floating.toggle                     ),
  awful.key({ s_mod, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
  awful.key({ s_mod,           }, "o",      awful.client.movetoscreen                        ),
  awful.key({ s_mod,           }, "t",      function(c) c.ontop = not c.ontop            end),
  awful.key({ s_mod,           }, "n",      function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end),
  awful.key({ s_mod,           }, "m",      function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
  end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
  -- View tag only.
  awful.key({ s_mod }, "#" .. i + 9, function()
    local screen = mouse.screen
    local tag = awful.tag.gettags(screen)[i]
    if tag then
      awful.tag.viewonly(tag)
    end
  end),
  -- Toggle tag.
  awful.key({ s_mod, "Control" }, "#" .. i + 9, function()
    local screen = mouse.screen
    local tag = awful.tag.gettags(screen)[i]
    if tag then
      awful.tag.viewtoggle(tag)
    end
  end),
  -- Move client to tag.
  awful.key({ s_mod, "Shift" }, "#" .. i + 9, function()
    if client.focus then
      local tag = awful.tag.gettags(client.focus.screen)[i]
      if tag then
        awful.client.movetotag(tag)
      end
    end
  end),
  -- Toggle tag.
  awful.key({ s_mod, "Control", "Shift" }, "#" .. i + 9, function()
    if client.focus then
      local tag = awful.tag.gettags(client.focus.screen)[i]
      if tag then
        awful.client.toggletag(tag)
      end
    end
  end))
end

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function(c) client.focus = c; c:raise() end),
awful.button({ s_mod }, 1, awful.mouse.client.move),
awful.button({ s_mod }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      size_hints_honor = false
    } },
  { rule = { class = "Pidgin", role = "buddy_list" },
    properties = { floating = true, width = 235, height = 450 } },
  { rule = { class = "Skype" },
    properties = { floating = true} },
  { rule = { class = "gimp" },
    properties = { floating = true } },
  { rule = { class = 'urxvt' },
    properties = { border = 0 } },
  { rule = { class = "Conky" },
    properties = {
      floating = true,
      sticky = true,
      ontop = false,
      focusable = false,
      size_hints = {"program_position", "program_size"}
    } }
}
-- }}}

-- {{{ Signals
-- Signal functionto execute when a new client appears.
client.connect_signal("manage", function(c, startup)
  -- Enable sloppy focus
  c:connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Put windows in a smart way, only if they does not set an initial position.
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end

  local titlebars_enabled = false
  if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
    awful.button({ }, 1, function()
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      client.focus = c
      c:raise()
      awful.mouse.client.resize(c)
    end)
    )

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(awful.titlebar.widget.iconwidget(c))
    left_layout:buttons(buttons)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(awful.titlebar.widget.floatingbutton(c))
    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
    right_layout:add(awful.titlebar.widget.stickybutton(c))
    right_layout:add(awful.titlebar.widget.ontopbutton(c))
    right_layout:add(awful.titlebar.widget.closebutton(c))

    -- The title goes in the middle
    local middle_layout = wibox.layout.flex.horizontal()
    local title = awful.titlebar.widget.titlewidget(c)
    title:set_align("center")
    middle_layout:add(title)
    middle_layout:buttons(buttons)

    -- Now bring it all together
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    layout:set_middle(middle_layout)

    awful.titlebar(c):set_widget(layout)
  end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
