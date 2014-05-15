#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

git submodule update --init --recursive
git submodule foreach --recursive git pull origin master

read -p "Auto compile YouCompleteMe? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo ""
  cd "$DIR"/../vim/bundle/YouCompleteMe
  ./install.sh
fi
echo ""

read -p "Auto install exuberant-ctags? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    git clone git://github.com/jakedouglas/exuberant-ctags.git ~/exuberant-ctags
    cd ~/exuberant-ctags
    ./configure
    make
    sudo make install
    rm -rf ~/exuberant-ctags
fi
echo ""
