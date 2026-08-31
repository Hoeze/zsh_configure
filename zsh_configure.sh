#!/bin/sh

wd=$(pwd)

export ZSH="${HOME}/.zsh/oh-my-zsh"

curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh && \
    cd ${ZSH}/custom/plugins && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions


########## CONFIGURE VIM ###########

git clone https://github.com/amix/vimrc.git ${HOME}/.vim_runtime
sh ${HOME}/.vim_runtime/install_awesome_vimrc.sh

mkdir -p ${HOME}/.vim/syntax
wget https://raw.githubusercontent.com/snakemake/snakemake/master/misc/vim/syntax/snakemake.vim -O ${HOME}/.vim/syntax/snakemake.vim
wget https://raw.githubusercontent.com/hashivim/vim-terraform/master/syntax/hcl.vim -O ${HOME}/.vim/syntax/hcl.vim
wget https://raw.githubusercontent.com/hashivim/vim-terraform/master/syntax/terraform.vim -O ${HOME}/.vim/syntax/terraform.vim

######### ----------- ##########


cp -rf ${wd}/home/. ${HOME}/

touch ${HOME}/.zshrc_local
touch ${HOME}/.env.d/local.env

########## CONFIGURE GIT ############

git config --global color.ui true
git config --global merge.conflictStyle zdiff3

# Pager and diff highlighting. On a host without delta, run
# diff-so-fancy_configure.sh by hand instead.
sh "${wd}/delta_configure.sh"

# KeePassXC merge driver
#
# Usage:
#  Create or update your .gitattributes file in the repository root:
#  ```
#  *.kdbx merge=keepassxc
#  ```
git config --global merge.keepassxc.name "KeePassXC Merge Driver"
git config --global merge.keepassxc.driver "keepassxc-cli merge -s %A %B"

######### ----------- ##########

