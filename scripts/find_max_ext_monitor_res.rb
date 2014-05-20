#!/usr/bin/env ruby

max_res = nil
scale = 1
default_x = `xrandr`.gsub(/.*LVDS.*?\n/m, '')
                    .gsub(/^\S.*/m, '')
                    .scan(/\d{1,4}(?=x.*\*)/)[0].to_f
max_x = default_x

`xrandr`.sub(/.*HDMI.*?\n/m, '').scan(/\d{1,4}x\d{1,4}i?p?/).each do |res|
  x, y = res.split(/[xip]/).map { |dim| dim.to_f }
  if x/y == 16.0/9.0
    unless max_res.nil?
      if x > max_x
        max_res, max_x = res, x
        scale = x/default_x
      end
    else
      max_res, max_x = res, x
      scale = x/default_x
    end
  end
end

system "$HOME/Documents/dotfiles/scripts/toggle_mirror_display.sh #{scale}x#{scale} #{max_res}"
