#!/bin/sh

# - Description
# Once you've cloned https://github.com/jimDragon/.dotfiles.git to
# $HOME/git/dotfiles - run this script to install everything else.

# When any command fails the shell immediately shall exit,
set -e

# Updating Arch
printf "\nUpdating Arch\n\n"
sudo pacman -Syu --noconfirm

# Stowing
mkdir -p $HOME/.config                      # Make the config folder so stowing everything doesn't just symlink the folder
rm -f $HOME/.bashrc                         # Sometimes there's a bashrc
sudo pacman -S stow --noconfirm --needed    # Installing stow
cd $HOME/git
printf "\nStowing Dotfiles\n\n"
stow dotfiles                               # Stowing the dotfiles

# Installing AUR Dependencies CHECK IF I NEED THIS
echo "\nInstalling AUR Dependencies\n\n"
sudo pacman -S --noconfirm vim base-devel --needed  # Installing base-devel if it's not installed already (This package contains everything required to build from the AUR)

# Build all packages (opening the PKGBUILD for each one)
# To get peak performance from building AUR packages set the "jobs" flag on
# the build software to be around the number of threads you have.
# E.g.
# make -j24
for PACKAGE in polybar oh-my-zsh-git ttf-font-awesome-4
do
  if [ ! -d "$HOME/git/$PACKAGE/" ]
  then
    printf "\nCloning $PACKAGE\n\n"
    git clone https://aur.archlinux.org/$PACKAGE.git --depth 1 $HOME/git/$PACKAGE
  fi

  printf "\nBuilding $PACKAGE\n\n"

  cd $HOME/git/$PACKAGE
  makepkg -si --noconfirm
done

# Setting Gruvbox GTK theme
GRUVBOX_GTK_FOLDER=$HOME/.themes/gruvbox-gtk/

if [ ! -d "$GRUVBOX_GTK_FOLDER" ]
then
  git clone https://github.com/bennetthardwick/gruvbox-gtk.git --depth 1 $GRUVBOX_GTK_FOLDER
fi

if [ ! -d "$HOME/git/gruvbox-arc-icon-theme/" ]
then
  cd $HOME/git/
  git clone https://github.com/bennetthardwick/gruvbox-arc-icon-theme --depth 1 gruvbox-arc-icon-theme
  cd gruvbox-arc-icon-theme
  ./autogen.sh --prefix=/usr
  sudo make install
fi

# Installing packages/dependencies
echo "\nInstalling Dependencies\n\n"
sudo pacman -S --noconfirm --needed \
  neovim \
  openssh \
  htop \
  sx \
  chromium \
  firefox \
  kitty \
  feh \
  zsh \
  zsh-autosuggestions \
  dunst \
  vifm \
  pulseaudio \
  imagemagick \
  pavucontrol

# Enabling services
# systemctl enable ntpd

# Installing dwm
# git clone and stuff

# Adding optional packages
printf "\nOptional Dependencies. Press n to not install.\n\n"
sudo pacman -S --needed \
  noto-fonts-extra \
  noto-fonts \
  noto-fonts-emoji \
  noto-fonts-cjk \
  fcitx \
  fcitx-gtk3 \
  fcitx-mozc \
  fcitx-configtool || echo "Not installing optional dependencies"

# Get zsh environment variables
source $HOME/.zshrc

# Installing development environments
# NEED Ruby env
# NEED Lamp stack with php 7
printf "\nInstalling N (Node version manager) through curl script\n\n"
if [ ! -x "$(command -v n)" ]
then
  sed -i '/^export\ N_PREFIX/d' $HOME/git/dotfiles/.zshrc
  N_PREFIX=$HOME/.n/ curl -L https://git.io/n-install | bash
  n lts
fi

# Return home so new shells open at home
cd $HOME

# startx
# sx