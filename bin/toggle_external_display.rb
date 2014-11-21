#!/usr/bin/env ruby

xrandr = `xrandr`.to_s

@common_monitors = { '3440x1440' => 'left', '2560x1440' => 'left' }
@audio_enabled_monitors = [ '3440x1440' ]
@restart_conky = ARGV.include?('--restart-conky') || system('pgrep openbox -u $USER >/dev/null')
@internal_monitor = xrandr.match(/((LVDS|eDP)\d*) connected/)[1]

def restart_background
  system "$HOME/.conkyinit --restart >/dev/null 2>&1" if @restart_conky
  system "(sleep 1 && $HOME/.fehbg) &"
end

def disable_monitor(external_monitor)
  system "xrandr --output #{external_monitor} --off --output #{@internal_monitor} --auto --scale 1.0x1.0"
  system "rm $HOME/.asoundrc 2>/dev/null"
  restart_background
end

def enable_mirror(external_monitor, resolution)
  system "xrandr --output #{external_monitor} --mode #{resolution} --same-as #{@internal_monitor} --output #{@internal_monitor} --scale-from #{resolution}"
  restart_background
end

def enable_multihead(external_monitor, resolution, side)
  system "xrandr --output #{external_monitor} --mode #{resolution} --#{side}-of #{@internal_monitor}"
  if @audio_enabled_monitors.include? resolution
    asoundrc = `cat $DOTFILES/.notebook`.strip
    system "ln -sf $DOTFILES/asound/asoundrc-#{asoundrc} $HOME/.asoundrc"
  end
  restart_background
end

if xrandr =~ /((HDMI|[^e]DP)(\d*)) (dis)?connected \d+x\d+/
  disable_monitor($1.strip)
elsif xrandr =~ /((HDMI|[^e]DP)(\d*)) connected/
  ext_mon = $1.strip
  resolutions = xrandr.sub(/.*#{ext_mon}.*?\n/m, '').scan(/\d{1,4}x\d{1,4}.*?(?=\s)/)
  resolutions = resolutions.sort_by { |res| x, y = res.split(/[^\d]/).map(&:to_f); -x*y }

  unless (common_resolutions = resolutions & @common_monitors.keys).empty?
    resolution = common_resolutions.first
    enable_multihead(ext_mon, resolution, @common_monitors[resolution])
  else
    enable_mirror(ext_mon, resolutions.first)
  end
end
