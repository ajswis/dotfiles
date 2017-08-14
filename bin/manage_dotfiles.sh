#!/bin/bash

# BASH_SOURCE means the directory location of this bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
exclude=("scripts" "README.md")
configs=("conky" "openbox" "tint2")

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
    echo ""

    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi

    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

link() {
  if [ -e "$1/.$2" ]; then
    if prompt "$1/.$2 exists! Delete?" N; then
      # It might be a very, very bad idea to rm -rf.
      rm -rf "$1/.$2"
      ln -sn "$DIR/$2" "$1/.$2"
    fi
    echo ""  # Intentional extra echo
  else
    ln -sn "$DIR/$2" "$1/.$2"
  fi
}

install_dotfiles() {
  mkdir -p $HOME/.config/{,xfce4/xfconf/xfce-perchannel-xml/xfce4-notifyd.xml/}
  confs=(
    'tmux.conf'
    'bashrc'
    'fehbg'
    'gitconfig'
    'gitignore'
    'git_template'
    'gtkrc-2.0'
    'vim'
    'vimrc'
    'xinitrc'
    'zshrc'
    'Xmodmap'
    'Xresources'
    'xbindkeysrc'
    'conkyinit'
    'config/conky'
    'config/openbox'
    'config/tint2'
    'config/touchegg'
    'config/awesome'
    'config/xfce4/xfconf/xfce-perchannel-xml/xfce4-notifyd.xml'
  )
  for conf in ${confs[@]}; do
    echo "Linking $conf to $HOME/.$conf"
    link "$HOME" "$conf"
  done

  # For neovim
  ln -sn $DIR/vim $HOME/.config/nvim
  ln -sn $DIR/vimrc $HOME/.config/nvim/init.vim

  # Finish up linking and directory stuff
  ln -fsn "$DIR"/vim/pathogen/autoload "$DIR"/vim/
  mkdir -p "$DIR"/vim/tmp/{backup,swap,undo}

  if prompt "Install airline glyphs?" N; then
    yaourt -S powerline-fonts-git
  fi
  mkdir -p "$DIR"/vim/tmp/{backup,swap,undo,view}
}

update_git_submodules() {
  git submodule foreach --recursive git reset --hard origin/master
  git submodule foreach --recursive git pull origin master
  git submodule foreach git submodule update --init --recursive
}

compile_ycm() {
  echo "Compiling YouCompleteMe"
  if prompt "Install boost (required for YCM)?" N; then
    yaourt -S boost
  fi

  cd "$DIR"/vim/bundle/YouCompleteMe
  python2 ./install.py --racer-completer
  cd "$DIR"
}

compile_exctags() {
  yaourt -S universal-ctags-git
}

case "$1" in
  -a|--all)
    install_dotfiles
    update_git_submodules
    compile_ycm
    compile_exctags
    ;;
  -i|--install_dotfiles)
    install_dotfiles
    ;;
  -g|--update_git_submodules)
    update_git_submodules
    ;;
  -y|--compile_ycm)
    compile_ycm
    ;;
  -e|--compile_exctags)
    compile_exctags
    ;;
  *)
    echo "Usage: manage_dotfiles <option>"
    echo "Options:"
    echo "    -i --install_dotfiles       Install dotfiles to home directory"
    echo "    -g --update_git_submodules  Update git submodules"
    echo "    -y --compile_ycm            Compile YouCompleteMe"
    echo "    -e --compile_exctags        Compile Exuberant-ctags"
    echo "    -a --all                    All of the above"
    ;;
esac
