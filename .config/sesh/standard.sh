#!/bin/bash
tmux set-hook -ug after-new-window
tmux rename-window -t standard:1 terminal
tmux new-window -t standard -n claude -c "$HOME/Documents/obsidian/Homelab"
tmux send-keys -t standard:claude "claude --continue" Enter
tmux new-window -t standard -n neovim -c "$HOME/Documents/obsidian/Homelab"
tmux send-keys -t standard:neovim "nvim" Enter
tmux new-window -t standard -n projects -c "$HOME/Documents/Projects"
tmux select-window -t standard:1
tmux set-hook -g after-new-window 'command-prompt -I "#{window_name}" "rename-window %%"'
