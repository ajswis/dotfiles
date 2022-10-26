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
  confs=(
    'ackrc'
    'ag-ignore'
    'bashrc'
    'git_template'
    'gitconfig'
    'gitignore'
    'tmux.conf'
    'vim'
    'vimrc'
    'zshrc'
  )
  for conf in ${confs[@]}; do
    echo "Linking $conf to $HOME/.$conf"
    link "$HOME" "$conf"
  done

  ln -fsn "$PWD/vim" "$HOME/.config/nvim"
  ln -fsn "$PWD/vimrc" "$HOME/.config/init.vim"

  # Finish up linking and directory stuff
  ln -fsn "$DIR"/vim/pathogen/autoload "$DIR"/vim/
  mkdir -p "$DIR"/vim/tmp/{backup,swap,undo,view}
}

update_git_submodules() {
  git submodule update --init --recursive

  # vim/bundle/YouCompleteMe/third_party/ycmd/third_party/mrab-regex doesn't
  # have a main/master branch, so include "hg"
  #
  # git fetch -a && \
  # git checkout -b rm_detached_head && \
  # (git checkout master || git checkout main || git checkout hg) && \
  # git branch -D rm_detached_head && \
  # (git reset --hard remotes/origin/master || git reset --hard remotes/origin/main || git reset --hard remotes/origin/hg)
  git submodule foreach --recursive zsh -c 'git fetch -a && git checkout -b rm_detached_head && (git checkout master || git checkout main || git checkout hg) && git branch -D rm_detached_head && (git reset --hard remotes/origin/master || git reset --hard remotes/origin/main || git reset --hard remotes/origin/hg)'
}

compile_ycm() {
  echo "Compiling YouCompleteMe"
  cd "$DIR"/vim/bundle/YouCompleteMe
  ./install.py --ts-completer --clang-completer --clangd-completer --cs-completer --rust-completer --java-completer
  cd "$DIR"
}

compile_exctags() {
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags
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
