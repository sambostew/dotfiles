#: Basic Exports {{{
#export UTF8
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

# Path to your oh-my-zsh installation.
export ZSH=/home/simon/.oh-my-zsh

#: }}}

#: Themeing {{{
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

#: }}}

#: Bindings {{{                      


#: }}}

#: Plugins & Plugin Configuration {{{

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf vi-mode ssh-agent)

# Add Github key to SSH agent
zstyle :omz:plugins:ssh-agent identities github

source $ZSH/oh-my-zsh.sh

#: }}}

#: Preferred editor for local and remote sessions {{{
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

#: }}}

#: Aliases {{{ 
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="lsd"
alias ll="lsd -la"

#Vim Alias

alias vi="vim $HOME/.config/i3/config"
alias vpi="vim $HOME/.config/picom/picom.conf"
alias vpo="vim $HOME/.config/polybar/config"
alias vr="vim $HOME/.config/rofi/config"
alias vd="vim $HOME/.config/dunst/dunstrc"
alias vz="vim $HOME/.zshrc"
alias vv="vim $HOME/.vimrc"
alias vh="vim $HOME/Documents/ansible/home-management.yml"
alias vt="vim $HOME/.config/tmux/tmux.conf"

#Git Alias

alias ga="git add"
alias gs="git status"
alias gc="git commit -m"
alias gp="git push origin master"

# Source files

alias sz="source $HOME/.zshrc"
alias sv="source $HOME/.vimrc"
alias st="source $HOME/.tmux.conf"

# TMUX alias

alias tn="tmux new -s TMUX"
alias tl="tmux ls"
alias ta="tmux attach"

#: }}}

#: Powerlevel Settings {{{
POWERLEVEL9K_MODE='awesome-fontconfig'
 
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="\u03bb/ "
 
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
#POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

#: }}}

#: Color Scheme & Neofetch {{{

neofetch --colors 208 227 208 208 227 

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#: }}} 
