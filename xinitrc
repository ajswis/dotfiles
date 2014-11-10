([[ -e $HOME/.Xmodmap ]] && xmodmap $HOME/.Xmodmap) &

exec openbox-session
#exec awesome
