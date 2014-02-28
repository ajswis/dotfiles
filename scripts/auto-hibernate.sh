#!/bin/bash

stat=$(cat /sys/class/power_supply/BAT0/uevent | grep STATUS | cut -f2 -d=)
batperc=$(cat /sys/class/power_supply/BAT0/uevent | grep CAPACITY | cut -f2 -d=)
if [[ $stat -eq "Discharging" ]] && [[ $batperc -eq "5" ]]; then
  /usr/bin/systemctl hibernate
fi
