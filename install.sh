#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
############################



########## Variables

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) # this directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gitconfig vimrc git-ignore-global"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "linking bash_profile in home directory."
if ! grep -Fxq $dir ~/.bash_profile; then
  echo "source $dir/bash_profile" >> ~/.bash_profile
fi

# echo "installing pathogen (for vim)"
# mkdir -p ~/.vim/autoload ~/.vim/bundle; \
# curl -Sso ~/.vim/autoload/pathogen.vim \
#     https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim