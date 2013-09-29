#!/bin/bash

step=3277

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
