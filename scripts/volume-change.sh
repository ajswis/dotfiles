#!/bin/bash

max=$(amixer get Master | grep Limits | cut -f7 -d' ')
step=$(( ($max+19)/20 ))

if [[ $# -eq 1 ]]; then
  case $1 in
    "up")
      amixer set Master $step+;;
    "down")
      amixer set Master $step-;;
    "toggle")
      amixer set Master toggle;;
    *)
      echo "Invalid option";;
  esac
fi
