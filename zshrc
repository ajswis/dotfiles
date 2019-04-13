HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt incappendhistory nomatch correct NO_HUP
unsetopt beep
bindkey -v

zstyle :compinstall filename '/Users/drew/.zshrc'
autoload -Uz compinit
compinit

autoload -U colors && colors
# Have to reset color to cyan after the bold tags for some reason.
PROMPT="%{$fg[cyan]%}[%n@%M %B%1~%b%{$fg[cyan]%}]%# %{$reset_color%}"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -G'

export EDITOR="mvim"
alias vim="mvim"
alias vimdiff="mvimdiff"

# OS X completions
fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# OS X keep current PWD when opening new tabs/windows
precmd () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}

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

export PAGER=less
export DOTFILES=$HOME/Documents/dotfiles
export PATH=$DOTFILES/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin
#export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/


source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias ack=ag

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
