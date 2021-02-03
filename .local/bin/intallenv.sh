#!/bin/sh

# Once you've cloned https://github.com/jimDragon/.dotfiles.git to
# $HOME/git/.dotfiles - run this script to install everything else.

# TODO list
# - install intel graphics and disable nvidia
# - install gruvbox gtk, terminal, vscode theme
# - install google fonts
# - install zsh
# - install dependencies
# - install envirorments (rbenv, LAMP stack)
# - install programming languages (python, go)

set -e                                      # When any command fails the shell immediately shall exit,

# Updating Arch
printf "\nUpdating Arch\n\n"
sudo pacman -Syu --noconfirm

# Stowing
mkdir -p $HOME/.config                      # Make the config folder so stowing everything doesn't just symlink the folder
rm -f $HOME/.bashrc                         # Sometimes there's a bashrc
sudo pacman -S stow --noconfirm --needed    # Installing stow
cd $HOME/git
printf "\nStowing Dotfiles\n\n"
stow .dotfiles                              # Stowing the .dotfiles folder

# Creating filesystem
for dir in dox dls pix cell
do
  mkdir -p $HOME/$dir
done

# Installing AUR Dependencies CHECK IF I NEED THIS
echo "\nInstalling AUR Dependencies\n\n"
sudo pacman -S --noconfirm vim base-devel --needed  # Installing base-devel if it's not installed already (This package contains everything required to build from the AUR)

# Build all packages
for PACKAGE in ttf-google-fonts-git
do
  if [ ! -d "$HOME/git/$PACKAGE/" ]
  then
    printf "\nCloning $PACKAGE\n\n"
    git clone https://aur.archlinux.org/$PACKAGE.git $HOME/git/$PACKAGE
  fi

  printf "\nBuilding $PACKAGE\n\n"

  cd $HOME/git/$PACKAGE
  makepkg -si --noconfirm
done

# Installing packages/dependencies
echo "\nInstalling Dependencies\n\n"
sudo pacman -S --noconfirm --needed \
  xorg-server xorg-xinit libx11 libxft \  # Packages used for dwm and dmenu
  xcalib \                                # For loading custom icc screen profile 
  neovim \
  openssh \
  htop \
  firefox \
  chromium \
  urxvt \
  feh \
  vifm \
  pulseaudio \
  pavucontrol \
  imagemagick \
  tldr \
  inkscape \
  code \
  zathura

# Enabling services
# systemctl enable ntpd

# Compiling suckless tools
for tool in dwm dmenu
do 
  cd $HOME/.local/src/$tool
  sudo make clean install
done

# Get zsh environment variables
source $HOME/.zshrc

# Installing development environments
# NEED Ruby env
# NEED Lamp stack with php 7

# Return home so new shells open at home
cd $HOME

startx