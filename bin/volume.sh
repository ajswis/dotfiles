card=1

if [ -f $HOME/.asoundrc ]; then
  card=0
fi

case "$1" in
  up)
    if [ $card == 0 ]; then
      /usr/bin/amixer -c $card sset Master 5%+
    else
      /usr/bin/amixer -c $card sset Master on
      /usr/bin/amixer -c $card sset Speaker on
      /usr/bin/amixer -c $card sset 'Bass Speaker' on
      /usr/bin/amixer -c $card sset Master 5%+
    fi
    ;;
  down)
    /usr/bin/amixer -c $card sset Master 5%-
    ;;
  toggle)
    if [ $card == 0 ]; then
      if [ $(/usr/bin/amixer -c 0 sget Master | /usr/bin/grep 'Front Left:' |
        /usr/bin/cut -d' ' -f 6) == "[0%]" ]; then
        /usr/bin/amixer -c $card sset Master 50%
      else
        /usr/bin/amixer -c $card sset Master 0%
      fi
    else
      /usr/bin/amixer -c $card sset Master toggle
    fi
    ;;
esac

