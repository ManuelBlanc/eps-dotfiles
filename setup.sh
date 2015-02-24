#!/usr/bin/env bash

# Clonar los dotfiles
cd ~
git init .
git remote add origin http://github.com/ManuelBlanc/eps-dotfiles.git
git clone origin master
git checkout -f origin/master

# git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle