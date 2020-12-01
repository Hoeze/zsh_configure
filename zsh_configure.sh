#!/bin/sh

wd=$(pwd)

export ZSH="${HOME}/.zsh/oh-my-zsh"

curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh && \
    cd ${ZSH}/custom/plugins && \
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git


########## CONFIGURE VIM ###########

git clone https://github.com/amix/vimrc.git ${HOME}/.vim_runtime
sh ${HOME}/.vim_runtime/install_awesome_vimrc.sh

mkdir -p ${HOME}/.vim/syntax
wget https://raw.githubusercontent.com/snakemake/snakemake/master/misc/vim/syntax/snakemake.vim -P ${HOME}/.vim/syntax/

######### ----------- ##########


cp -rf ${wd}/home/. ${HOME}/

touch ${HOME}/.zshrc_local
touch ${HOME}/.env.d/local.env

########## CONFIGURE GIT ############

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# improved git colors from diff-so-fancy

git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

######### ----------- ##########

