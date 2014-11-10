if [ -e $HOME/.Xmodmap ]; then
  xmodmap $HOME/.Xmodmap &
fi

exec openbox-session
#exec awesome
