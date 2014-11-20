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

export DOTFILES=$HOME/Documents/dotfiles
export PATH=$DOTFILES/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

