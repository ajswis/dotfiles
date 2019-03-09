# If not running interactively, don't do anything
case $- in
  *i*) ;;
*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

case "$TERM" in
  xterm*|rxvt*)
    PS1='[\u@\h \W]\$ '
    ;;
  *)
    ;;
esac

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -G'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export EDITOR="mvim"
alias vim="mvim"

dot_sync() {
  current_branch=$(git branch | grep '\*.*' | cut -d '*' -f 2 | tr -d ' ')
  if [ -z "$1" ]; then
    1=$current_branch
  fi

  for branch in $(git branch | grep '^[^*].*$'); do
    git ch $branch
    git cherry-pick $1 || { echo 'Problems.. manually cherry-pick'; return 0 }
  done
  git ch $current_branch
}

rmorig() {
  if [ "$1" = "-f" ]; then
    find . -name "*.orig" -print -delete
  else
    find . -name "*.orig" -print
  fi
}

export PAGER=less
export DOTFILES=$HOME/Documents/dotfiles
export PATH=$DOTFILES/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin
#export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/


alias ack=ag

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
