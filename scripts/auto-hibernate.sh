#!/bin/bash

stat=$(cat /sys/class/power_supply/BAT0/uevent | grep STATUS | cut -f2 -d=)
batperc=$(cat /sys/class/power_supply/BAT0/uevent | grep CAPACITY | cut -f2 -d=)
if [[ $stat -eq "Discharging" ]]; then
  export DISPLAY=:0.0
  if [[ $batperc -le 7 ]]; then
    # This will, and should, spam me when my battery gets low.
    notify-send 'Battery is low!' 'Save your work, idiot!' --icon=battery-low
  fi
  if [[ $batperc -eq 0 ]]; then
    # TODO: Find a way to not use sudo/editing sudoers
    notify-send 'Doing you a favor, buddy.' --icon=battery-low
    sleep 2 && sudo /usr/bin/systemctl hibernate
  fi
fi
