#!/usr/bin/env ruby

xrandr = `xrandr`.to_s

@common_monitors = { '3440x1440' => 'left', '2560x1440' => 'left' }
@restart_background = ARGV.include?('--restart-background') || system('pgrep openbox -u $USER >/dev/null')
@internal_monitor = xrandr.match(/((LVDS|eDP)\d*) connected/)[1]

def restart_background
  if @restart_background
    system "$HOME/.conkyinit --restart >/dev/null 2>&1"
    system "$HOME/.fehbg"
  end
end

def disable_monitor(external_monitor)
  system "xrandr --output #{external_monitor} --off --output #{@internal_monitor} --auto --scale 1.0x1.0"
  restart_background
end

def enable_mirror(external_monitor, resolution)
  system "xrandr --output #{external_monitor} --mode #{resolution} --same-as #{@internal_monitor} --output #{@internal_monitor} --scale-from #{resolution}"
  restart_background
end

def enable_multihead(external_monitor, resolution, side)
  system "xrandr --output #{external_monitor} --mode #{resolution} --#{side}-of #{@internal_monitor}"
  restart_background
end

if xrandr =~ /((HDMI|[^e]DP)(\d*)) (dis)?connected \d+x\d+/
  disable_monitor($1)
elsif xrandr =~ /((HDMI|[^e]DP)(\d*)) connected/
  ext_mon = $1
  resolutions = xrandr.sub(/.*#{ext_mon}.*?\n/m, '').scan(/\d{1,4}x\d{1,4}.*?(?=\s)/)
  resolutions = resolutions.sort_by { |res| x, y = res.split(/[^\d]/).map(&:to_f); -x*y }

  unless (common_resolutions = resolutions & @common_monitors.keys).empty?
    resolution = common_resolutions.first
    enable_multihead(ext_mon, resolution, @common_monitors[resolution])
  else
    enable_mirror(ext_mon, resolutions.first)
  end
end