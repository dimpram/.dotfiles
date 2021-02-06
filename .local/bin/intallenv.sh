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
echo -e "\nUpdating Arch\n\n"
sudo pacman -Syu --noconfirm

# Stowing
mkdir -p $HOME/.config                      # Make the config folder so stowing everything doesn't just symlink the folder
rm -f $HOME/.bashrc $HOME/.bash_profile     # Sometimes there's a bashrc
sudo pacman -S stow --noconfirm --needed    # Installing stow
cd $HOME/git
echo -e "\nStowing Dotfiles\n\n"
stow .dotfiles                              # Stowing the .dotfiles folder

# Creating filesystem
for dir in dox dls pix cell
do
  mkdir -p $HOME/$dir
done

# Installing AUR Dependencies CHECK IF I NEED THIS
echo -e "\nInstalling AUR Dependencies\n\n"
sudo pacman -S --noconfirm vim base-devel --needed  # Installing base-devel if it's not installed already (This package contains everything required to build from the AUR)

# Build all packages
for PACKAGE in ttf-merriweather ttf-merriweather-sans ttf-oswald ttf-quintessential ttf-signika ttf-google-fonts-git
do
  if [ ! -d "$HOME/git/$PACKAGE/" ]
  then
    echo -e "\nCloning $PACKAGE\n\n"
    git clone https://aur.archlinux.org/$PACKAGE.git $HOME/git/$PACKAGE
  fi

  echo -e "\nBuilding $PACKAGE\n\n"

  cd $HOME/git/$PACKAGE
  makepkg -si --noconfirm
done

# Installing packages/dependencies
echo -e "\nInstalling Dependencies\n\n"
sudo pacman -S --noconfirm --needed \
  xf86-video-fbdev \
  xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libx11 libxft \
  xcalib \
  neovim \
  openssh \
  htop \
  firefox \
  chromium \
  rxvt-unicode \
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
for tool in dmenu dwm
do 
  cd $HOME/.local/src/$tool
  sudo make clean install
done

# Get zsh (or bash) environment variables
# source $HOME/.zshrc
source $HOME/.bashrc

# Installing development environments
# NEED Ruby env
# NEED Lamp stack with php 7

# Return home so new shells open at home
cd $HOME

startx
