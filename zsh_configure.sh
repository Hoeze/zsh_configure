#!/bin/sh

wd=$(pwd)

export ZSH="${HOME}/.zsh/oh-my-zsh"

# Fast-forward the checkout at $1. A merge or a rebase here would touch someone
# else's working tree, so refuse anything that is not a clean fast-forward and
# carry on rather than aborting the install.
update_checkout() {
    echo "updating: $1"
    git -C "$1" pull --ff-only || echo "could not fast-forward $1, left as is" >&2
}

# Clone $1 into $2, or update $2 if it is already a checkout. Keeps the script
# re-runnable: a plain `git clone` over an existing directory is a fatal error.
clone_or_update() {
    if [ -d "$2/.git" ]; then
        update_checkout "$2"
    elif [ -e "$2" ]; then
        echo "not a git checkout, left as is: $2" >&2
    else
        git clone "$1" "$2"
    fi
}

# The oh-my-zsh installer refuses to run when $ZSH already exists, so on a
# second run update the checkout in place instead. That is what `omz update`
# does anyway.
if [ -d "${ZSH}/.git" ]; then
    update_checkout "${ZSH}"
elif [ -e "${ZSH}" ]; then
    echo "not a git checkout, left as is: ${ZSH}" >&2
else
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH}/custom/plugins/zsh-syntax-highlighting"
clone_or_update https://github.com/zsh-users/zsh-completions \
    "${ZSH_CUSTOM:-${ZSH}/custom}/plugins/zsh-completions"


########## CONFIGURE VIM ###########

clone_or_update https://github.com/amix/vimrc.git "${HOME}/.vim_runtime"
sh ${HOME}/.vim_runtime/install_awesome_vimrc.sh

mkdir -p ${HOME}/.vim/syntax
wget https://raw.githubusercontent.com/snakemake/snakemake/master/misc/vim/syntax/snakemake.vim -O ${HOME}/.vim/syntax/snakemake.vim
wget https://raw.githubusercontent.com/hashivim/vim-terraform/master/syntax/hcl.vim -O ${HOME}/.vim/syntax/hcl.vim
wget https://raw.githubusercontent.com/hashivim/vim-terraform/master/syntax/terraform.vim -O ${HOME}/.vim/syntax/terraform.vim

######### ----------- ##########


# This copy is a blunt overwrite, so anything added locally to a tracked file
# is lost. Keep a copy of what changes, and say where it went.
backup="${HOME}/.zsh_configure_backup/$(date +%Y%m%d-%H%M%S)"
( cd "${wd}/home" && find . -type f -print ) | while read -r f; do
    [ -f "${HOME}/${f}" ] || continue
    cmp -s "${wd}/home/${f}" "${HOME}/${f}" && continue
    mkdir -p "${backup}/$(dirname "${f}")"
    cp -p "${HOME}/${f}" "${backup}/${f}"
done
[ -d "${backup}" ] && echo "replaced files backed up to ${backup}"

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

