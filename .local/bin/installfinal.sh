#! /usr/bin/env bash

# Install MacOS theme
cd $HOME/git
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git theme
cd theme
./install.sh
cd $HOME/git
rm -rf theme

# Install MacOS Icons
cd $HOME/git
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git icons
cd icons
./install.sh
cd $HOME/git
rm -rf icons
