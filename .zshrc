# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/simon/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG="en_GB.UTF-8"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="ls -larht"

#PS1='[\u@\h \W]\$ '

screenfetch

# powerline
#powerline-daemon -q
#. /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

POWERLEVEL9K_MODE='awesome-fontconfig'
 
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="\u03bb/ "
 
 
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
#POWERLEVEL9K_SHORTEN_DIR_LENGTH=3            
