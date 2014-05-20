#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
exclude=("scripts")

elemIn() {
  for e in "${@:2}"; do
    [[ "$e" = "$1" ]] && return 1
  done
  return 0
}

link() {
  if [ -e "$1/$3$2" ]; then
    read -p "$1/$3$2 exists! Delete? [y/N] " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
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
  elemIn "$i" "${exclude[@]}"
  if [[  $? == 1 ]]; then continue; fi
  echo "Linking $i to $HOME/.$i"
  link "$HOME" "$i" "."
done

ln -fsn $DIR/../vim "$HOME"/.vim
ln -fsn $DIR/../vim/pathogen/autoload "$DIR"/../vim/
mkdir -p "$DIR"/../vim/tmp/{backup,swap,undo}
git submodule update --init --recursive
git submodule foreach --recursive git pull origin master

read -p "Auto compile YouCompleteMe? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo ""
  echo "Compiling YouCompleteMe"
  cd "$DIR"/../vim/bundle/YouCompleteMe
  ./install.sh
fi
echo ""

read -p "Auto compile exuberant-ctags? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo ""
  git clone git://github.com/jakedouglas/exuberant-ctags.git "$DIR"/exuberant-ctags
  cd "$DIR"/exuberant-ctags
  ./configure
  make
  sudo make install
  rm -rf "$DIR"/exuberant-ctags
fi
echo ""
