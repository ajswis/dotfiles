([[ -e $HOME/.Xmodmap ]] && xmodmap $HOME/.Xmodmap) &
([[ -e $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources) &
(pgrep -u $USER urxvtd || /usr/bin/urxvtd -q -o -f) &

exec openbox-session
#exec awesome
