source $HOME/.oh-my-zshrc

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt incappendhistory nomatch correct NO_HUP
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/drew/.zshrc'

autoload -Uz compinit
compinit

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
export EDITOR="nvim"
alias vim="nvim"

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

# Set Home, End, Del, PgUp, PgDown keys to actually do something.
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history

if [ -x /usr/bin/ssh-agent -a -z "$SSH_AUTH_SOCK" ]; then
  eval "$(keychain --eval -Q -q --agents ssh  `find $HOME/.ssh/*  ! -name '*.pub' ! -name 'config' ! -name 'known_hosts'`)"
fi

export PAGER=less
export DOTFILES=$HOME/Documents/dotfiles
export GOPATH=$HOME/Documents/go
export PATH=$DOTFILES/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin
export PATH=$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.c.zsh
source $HOME/.2fak.zsh

alias yaourt=pikaur
alias pacaur=pikaur
alias ack=rg

# added by travis gem
[ -f /home/drew/.travis/travis.sh ] && source /home/drew/.travis/travis.sh

export DOTNET_CLI_TELEMETRY_OPTOUT=1

plugins=(
  aws
  bundler
  cargo
  docker
  docker-compose
  git
  npm
  npx
  rails
  rake
  ruby
  rust
  rvm
  yarn
  yarn
)
