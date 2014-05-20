#!/bin/bash

# BASH_SOURCE means the directory location of this bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
exclude=("scripts" "README.md")
configs=("conky" "openbox" "tint2")

elem_in() {
  for e in "${@:2}"; do
    [[ "$e" = "$1" ]] && return 1
  done
  return 0
}

prompt() {
  while true; do
    if [ "${2:-}" = "Y" ]; then
      options="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      options="y/N"
      default=N
    else
      options="y/n"
      default=
    fi

    read -p "$1 [$options] " -n 1 -r REPLY

    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi

    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  echo ""
  done
}

link() {
  if [ -e "$1/$3$2" ]; then
    if prompt "$1/$3$2 exists! Delete?" N; then
      # It might be a very, very bad idea to rm -rf.
      rm -rf "$1/$3$2"
      ln -sn "$DIR/$2" "$1/$3$2"
    fi
    echo ""
  else
    ln -sn "$DIR/$2" "$1/$3$2"
  fi
}

for i in $(ls "$DIR"); do
  elem_in "$i" "${exclude[@]}"
  if [[  $? == 1 ]]; then continue; fi
  elem_in "$i" "${configs[@]}"
  if [[ $? == 1 ]]; then
    echo "Linking $i to $HOME/.config/$i"
    link "$HOME/.config" "$i"
  else
    echo "Linking $i to $HOME/.$i"
    link "$HOME" "$i" "."
  fi
done

ln -fsn "$DIR"/vim/pathogen/autoload "$DIR"/vim/
mkdir -p "$DIR"/vim/tmp/{backup,swap,undo}

git submodule update --init --recursive
git submodule foreach --recursive git pull origin master

#Very specific to Arch
if prompt "Install boost and airline glyphs?" N; then
  yaourt -S boost powerline-fonts-git
fi
echo ""

if prompt "Auto compile YouCompleteMe?" N; then
  echo ""
  echo "Compiling YouCompleteMe"
  cd "$DIR"/vim/bundle/YouCompleteMe
  ./install.sh
fi
echo ""

if prompt "Auto compile exuberant-ctags?" N; then
  echo ""
  git clone git://github.com/jakedouglas/exuberant-ctags.git "$DIR"/exuberant-ctags
  cd "$DIR"/exuberant-ctags
  ./configure
  make
  sudo make install
  rm -rf "$DIR"/exuberant-ctags
fi
echo ""
