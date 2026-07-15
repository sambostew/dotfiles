#: Basic Exports {{{
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# Secrets (not tracked in dotfiles)
[ -f ~/.secrets ] && source ~/.secrets
#: }}}

#: History {{{
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY
#: }}}

#: Options {{{
setopt AUTO_CD CORRECT INTERACTIVE_COMMENTS
bindkey -v
KEYTIMEOUT=1
#: }}}

#: Completion {{{
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
#: }}}

#: SSH agent (github key) {{{
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null
    ssh-add -q ~/.ssh/github 2>/dev/null
fi
#: }}}

#: Editor {{{
export EDITOR='vim'
#: }}}

#: Aliases {{{

# Claude Code — run symlink sync before launching
alias claude='claude-sync-links; command claude'

# Wrap pywal so ghostty's background stays black after every recolour.
# Pywal broadcasts OSC 11 to running terminals; ghostty's config #000000
# only applies to new windows, so force-reset the bg on all open ptys.
wal() {
	command wal "$@"
	local rc=$?
	for pts in /dev/pts/[0-9]*; do
		printf '\033]11;#000000\007' > "$pts" 2>/dev/null
	done
	return $rc
}

if [[ $OSTYPE == linux* ]]; then

	# Bare `tmux` (no args, not inside tmux) → drop straight into the sesh `standard`
	# session (or attach if already running). Use `prefix + s` for the sesh picker,
	# or pass any args to bypass (e.g. `tmux ls`, `tmux new -s foo`).
	tmux() {
		if [[ -z "$TMUX" && $# -eq 0 ]]; then
			exec command sesh connect standard
		else
			command tmux "$@"
		fi
	}

	# Ctrl+O — fuzzy-find a file in the obsidian vault via television, open in nvim
	_tv_vault_widget() {
		local vault="$HOME/Documents/obsidian"
		local file
		file=$(tv files "$vault" </dev/tty)
		if [[ -n "$file" ]]; then
			BUFFER="nvim ${(q)file}"
			zle accept-line
		else
			zle reset-prompt
		fi
	}
	zle -N _tv_vault_widget
	bindkey '^O' _tv_vault_widget

	# Use eza instead of ls (icons + inline git status)
	alias ls="eza --icons --group-directories-first"
	alias ll="eza -la --icons --git --group-directories-first"
	alias menu="./.config/polybar/launch.sh"

	# Vim Alias Linux
	alias vi="vim $HOME/.config/i3/config"
	alias vpi="vim $HOME/.config/picom/picom.conf"
	alias vpo="vim $HOME/.config/polybar/config"
	alias vr="vim $HOME/.config/rofi/config"
	alias vd="vim $HOME/.config/dunst/dunstrc"
	alias vh="vim $HOME/Documents/ansible/home-management.yml"

	# Use eza --tree instead of standard tree
	alias tree="eza --tree --icons"

	# Change color scheme and paging for bat
	alias bat="bat --theme=ansi-light --pager=never"

fi

# Vim Alias all OS
alias vt="vim $HOME/.tmux.conf"
alias vz="vim $HOME/.zshrc"
alias vv="vim $HOME/.vimrc"

# Git Alias
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

#: Color Scheme & Fastfetch {{{

fastfetch

# Apply pywal's ANSI palette but strip the warm-tinted background (OSC 11) and
# color0 (OSC 4;0) escapes — godmode.jpg extracts to #0A0202 for both, which
# tinted the terminal brown at 0.8 opacity. Keeping the other 15 colour remappings so
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

#: Plugins (must be sourced AFTER completion, before prompt) {{{
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#: }}}

#: Prompt (Starship — must be last) {{{
eval "$(starship init zsh)"
#: }}}
