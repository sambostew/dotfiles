#: Basic Exports {{{
#export UTF8
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=/home/simon/.oh-my-zsh

# Secrets (not tracked in dotfiles)
[ -f ~/.secrets ] && source ~/.secrets
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

# Claude Code — run symlink sync before launching
alias claude='claude-sync-links; command claude'

if [[ $OSTYPE == linux* ]]; then

	# Use lsd instead of ls for aesthetics
	alias ls="lsd --group-dirs first"
	alias ll="lsd -la"
	alias menu="./.config/polybar/launch.sh"

	#Vim Alias Linux

	alias vi="vim $HOME/.config/i3/config"
	alias vpi="vim $HOME/.config/picom/picom.conf"
	alias vpo="vim $HOME/.config/polybar/config"
	alias vr="vim $HOME/.config/rofi/config"
	alias vd="vim $HOME/.config/dunst/dunstrc"
	alias vh="vim $HOME/Documents/ansible/home-management.yml"
	# Use lsd --tree instead of standard tree
	alias tree="lsd --tree"

	# Change color scheme and paging for bat 
	alias bat="bat --theme=ansi-light --pager=never"

fi

# Vim Alias all OS

alias vt="vim $HOME/.tmux.conf"
alias vz="vim $HOME/.zshrc"
alias vv="vim $HOME/.vimrc"

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

# Apply pywal's ANSI palette but strip the warm-tinted background (OSC 11) and
# color0 (OSC 4;0) escapes — godmode.jpg extracts to #0A0202 for both, which
# tinted kitty brown at 0.8 opacity. Keeping the other 15 colour remappings so
# the prompt theme keeps its pywal-derived colours (e.g. "ANSI blue" → yellow).
sed -E 's/\x1b\]11;[^\x1b]*\x1b\\//g; s/\x1b\]4;0;[^\x1b]*\x1b\\//g' ~/.cache/wal/sequences 2>/dev/null
source ~/.cache/wal/colors-tty.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#: }}} 

#: Kubernetes {{{

source <(kubectl completion zsh)
alias k="kubectl"

#: }}}

#: Zoxide {{{

eval "$(zoxide init zsh)"

#: }}}
