#!/bin/bash

stat=$(cat /sys/class/power_supply/BAT0/status)
batperc=$(cat /sys/class/power_supply/BAT0/capacity)
if [[ $stat -eq "Discharging" ]]; then
  if [ $batperc -le 8 ]; then
    notify-send 'HEY! Your battery is low!' 'Save your work!!' -i battery-low -t 20000
  fi
  if [ $batperc -eq 1 ]; then
    notify-send 'Doing you a favor, buddy.' -i battery-low -u critical
    sleep 2 && systemctl hibernate
  fi
fi
