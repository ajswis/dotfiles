HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt incappendhistory nomatch correct
unsetopt beep
bindkey -v

zstyle :compinstall filename '/Users/drew/.zshrc'
autoload -Uz compinit
compinit

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

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

# Set Home, End, Del, PgUp, PgDown keys to actually do something.
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history

export DOTFILES=$HOME/Documents/dotfiles
export PATH=$DOTFILES/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
