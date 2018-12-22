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


### Todo

1. change vim installer from pathogen to vundle
reason: easier portability

2. remove installation links to github vim plugins after vundle migration

3. create installation script or ansible playbook


# Pulling config files

git clone https://github.com/sambostew/dotfiles.git

create symbolic link

ls -n ~/dotfiles/.vimrc .vimrc
ls -n ~/dotfiles/.zshrc .zshrc.conf
ls -n ~/dotfiles/.tmux.conf .tmux.conf

### Notes

Baterry status added to tmux for laptop

