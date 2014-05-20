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
  if [ -e "$1/$3$2" ]; then
    if prompt "$1/$3$2 exists! Delete?" N; then
      # It might be a very, very bad idea to rm -rf.
      rm -rf "$1/$3$2"
      ln -sn "$DIR/$2" "$1/$3$2"
    fi
    echo ""  # Intentional extra echo
  else
    ln -sn "$DIR/$2" "$1/$3$2"
  fi
}

install_dotfiles() {
  for i in $(ls "$DIR"); do
    # Ignore some files
    elem_in "$i" "${exclude[@]}"
    if [[  $? == 1 ]]; then continue; fi

    # Differentiate between dotfiles and .config/* files
    elem_in "$i" "${configs[@]}"
    if [[ $? == 1 ]]; then
      echo "Linking $i to $HOME/.config/$i"
      link "$HOME/.config" "$i"
    else
      echo "Linking $i to $HOME/.$i"
      link "$HOME" "$i" "."
    fi
  done

  # Finish up linking and directory stuff
  ln -fsn "$DIR"/vim/pathogen/autoload "$DIR"/vim/
  mkdir -p "$DIR"/vim/tmp/{backup,swap,undo}
}

update_git_submodules() {
  git submodule update --init --recursive
  git submodule foreach --recursive git pull origin master
}

compile_ycm() {
  echo "Compiling YouCompleteMe"
  cd "$DIR"/vim/bundle/YouCompleteMe
  ./install.sh
  cd "$DIR"
}

compile_exctags() {
  git clone git://github.com/jakedouglas/exuberant-ctags.git "$DIR"/exuberant-ctags
  cd "$DIR"/exuberant-ctags
  ./configure
  make
  sudo make install
  rm -rf "$DIR"/exuberant-ctags
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
