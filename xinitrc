#!/bin/sh
export DOTFILES=$HOME/Documents/dotfiles

([[ -e $HOME/.Xmodmap ]] && xmodmap $HOME/.Xmodmap) &
([[ -e $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources) &
([[ -e $HOME/.xbindkeysrc ]] && xbindkeys -f $HOME/.xbindkeysrc) &
(pgrep -u $USER urxvtd || /usr/bin/urxvtd -q -o -f) &

#exec openbox-session
exec awesome
