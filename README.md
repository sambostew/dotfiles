# dotfiles
# My Config Dotfiles

## Installation 

1. Install zsh
2. Install oh-my-zsh:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
3. Change shell - chsh -s '/location/zsh'

## Powerline9k

https://github.com/powerline/fonts

## NerdTree

https://github.com/scrooloose/nerdtree

## Pear of Ducks

https://github.com/pearofducks/ansible-vim

## Auto suggestions

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

## fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

### Todo

1. Update tmux.conf with nesting options for remote sessions, see link in file

2. change vim installer from pathogen to vundle
reason: easier portability

3. remove installation links to github vim plugins after vundle migration

4. create installation script or ansible playbook
5. Integrate gnu stow for symblic link management
https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
6. Update Ranger config files for fzf keybindings

# Pulling config files

git clone https://github.com/sambostew/dotfiles.git

create symbolic link

ls -n ~/dotfiles/.vimrc .vimrc
ls -n ~/dotfiles/.zshrc .zshrc.conf
ls -n ~/dotfiles/.tmux.conf .tmux.conf

### Notes

Baterry status added to tmux for laptop


### Tmux keybindings

| Description | Command |
| ---     | ---         |
| prefix  | `ctrl +b`     |
| new window | `c`|
| next-window | `n` |
| next-window | `shift right arrow`|
| previous-window | `p` |
| previous-window | `shift left arrow` |
| switch pane left | `left arrow` |
| switch pane left | `h` |
| switch pane right| `right arrow`|
| switch pane right| `l` |
| detatch |`d` |
| rename     | `r`      |
| reload config     | `R`      |
| horizontal split     | `H`|
| vertical split  | `v`|
| kill pane | `x` |
| kill window | `X` |
| bind/unbind mouse | `m` |
