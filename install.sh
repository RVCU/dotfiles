#!/bin/bash
user=$(whoami)
mkdir -p backups
mv -f /home/"$user"/.bashrc backups
mv -f /home/"$user"/.tmux.conf backups
mv -f /home/"$user"/.vimrc backups
rm -rf /home/"$user"/.vim/vimrc.d/ backups

ln  bashrc /home/"$user"/.bashrc 
ln  tmux.conf /home/"$user"/.tmux.conf
ln  vimrc /home/"$user"/.vimrc
ln git-identity ~/bin/git-identity
mkdir -p /home/"$user"/.vim/vimrc.d/
cp -rpf vimrc.d/ /home/"$user"/.vim/
mkdir -p /home/"$user"/.vim/templates
cp -rpf templates/* /home/"$user"/.vim/templates

