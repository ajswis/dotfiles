#!/bin/bash

IN="LVDS1"
EXT="HDMI1"

if (xrandr | grep "$EXT disconnected"); then
  xrandr --output $IN --auto --scale 1.0x1.0 --output $EXT --off
  $HOME/.fehbg
  killall conky 1>/dev/null 2>&1
  conky -c $HOME/.config/conky/conkyrc 1>/dev/null 2>&1 &
else
  xrandr --output $IN --scale $1 \
         --output $EXT --auto --mode $2 --same-as $IN
  $HOME/.fehbg
  killall conky 1>/dev/null 2>&1
  conky -c $HOME/.config/conky/conkyrc 1>/dev/null 2>&1 &
fi
