#!/bin/sh
export DOTFILES=$HOME/Documents/dotfiles

([[ -e $HOME/.Xmodmap ]] && xmodmap $HOME/.Xmodmap) &
([[ -e $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources) &
([[ -e $HOME/.xbindkeysrc ]] && xbindkeys -f $HOME/.xbindkeysrc) &
(pgrep -u $USER xautolock || /usr/bin/xautolock -time 10 -locker /usr/bin/slimlock -nowlocker /usr/bin/slimlock -detectsleep) &
(pgrep -u $USER urxvtd || /usr/bin/urxvtd -q -o -f) &

exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
