# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt incappendhistory nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/drew/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export EDITOR="vim"
export PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin
export PATH=$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools

autoload -U colors && colors
# Have to reset color to cyan after the bold tags for some reason.
PROMPT="%{$fg[cyan]%}[%n@%M %B%1~%b%{$fg[cyan]%}]%# %{$reset_color%}"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'

# Allow ctrl+S in vim to save files, ie pass
# the command to vim when vim is open.
vim() {
  local STTYOPTS="$(stty --save)"
  stty stop '' -ixoff
  command vim --servername vim "$@"
  stty "$STTYOPTS"
}

alias xbox_controller='sudo xboxdrv --config ~/Documents/xboxdrv_profiles/wiredxbox_minecraft.conf --detach-kernel-driver'

# Set Home, End, Del, PgUp, PgDown keys to actually do something.
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
