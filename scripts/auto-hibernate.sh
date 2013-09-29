#!/bin/bash

batperc=$(cat /sys/class/power_supply/BAT0/uevent | grep CAPACITY | cut -f2 -d=)
if [[ $batperc -eq "2" ]]; then
  /usr/bin/systemctl hibernate
fi
