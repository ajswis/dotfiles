# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt incappendhistory nomatch correct
unsetopt beep
bindkey -v

zstyle :compinstall filename '/home/drew/.zshrc'

autoload -Uz compinit
compinit

export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export EDITOR="vim"

autoload -U colors && colors
# Have to reset color to cyan after the bold tags for some reason.
PROMPT="%{$fg[cyan]%}[%n@%M %B%1~%b%{$fg[cyan]%}]%# %{$reset_color%}"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
eval "$(hub alias -s)"

# Allow ctrl+S in vim to save files, ie pass
# the command to vim when vim is open.
vim() {
  local STTYOPTS="$(stty --save)"
  stty stop '' -ixoff
  command vim --servername vim "$@"
  stty "$STTYOPTS"
}

# Set Home, End, Del, PgUp, PgDown keys to actually do something.
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history

if [ -x /usr/bin/ssh-agent -a -z "$SSH_AUTH_SOCK" ]; then
  eval "$(keychain --eval -Q -q --agents ssh  `find $HOME/.ssh/*  ! -name '*.pub' ! -name 'config' ! -name 'known_hosts'`)"
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

