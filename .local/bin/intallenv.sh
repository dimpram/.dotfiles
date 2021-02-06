#!/bin/sh

# Once you've cloned https://github.com/jimDragon/.dotfiles.git to
# $HOME/git/.dotfiles - run this script to install everything else.

# Action list
# - Update Arch
# - Set custom tty font
# - Stow dotfiles
# - Crete Directories
# - install AUR dependencies
# - install dependencies
# - Build suckless tools
# - Source bash
# - install envirorments (rbenv, LAMP stack) / programming languages (python, go)
# - Add xiaomi optimizations


# notes
#
# Set keyboard languages
# /etc/X11/xorg.conf.d/00-keyboard.conf
#
# Section "InputClass"
#        Identifier "system-keyboard"
#        MatchIsKeyboard "on"
#        Option "XkbLayout" "us,gr"
#        Option "XkbModel" "pc105"
#        # Option "XkbVariant"
#        Option "XkbOptions" "grp:alt_shift_toggle"
# EndSection

set -e                                      # When any command fails the shell immediately shall exit,

# Updating Arch
echo -e "\nUpdating Arch\n"
sudo pacman -Syu --noconfirm

# Installing custom tty font
echo -e "\Set Terminus TTY Font\n"
sudo pacman -S terminus-font
setfont ter-v32n

# Stowing
echo -e "\nStowing Dotfiles\n"
mkdir -p $HOME/.config                      # Make the config folder so stowing everything doesn't just symlink the folder
rm -f $HOME/.bashrc $HOME/.bash_profile     # Sometimes there's a bashrc or a bash_profile
sudo pacman -S stow --noconfirm --needed    # Installing stow
cd $HOME/git
stow .dotfiles                              # Stowing the .dotfiles folder

# Creating filesystem
for dir in dox dls cell
do
  mkdir -p $HOME/$dir
done

# Installing AUR Dependencies CHECK IF I NEED THIS
echo -e "\nInstalling AUR Dependencies\n"
sudo pacman -S --noconfirm vim base-devel --needed  # Installing base-devel if it's not installed already (This package contains everything required to build from the AUR)

# Build all packages
for PACKAGE in ttf-merriweather ttf-merriweather-sans ttf-oswald ttf-quintessential ttf-signika ttf-google-fonts-git brave-bin
do
  if [ ! -d "$HOME/git/$PACKAGE/" ]
  then
    echo -e "\nCloning $PACKAGE\n"
    git clone https://aur.archlinux.org/$PACKAGE.git $HOME/git/$PACKAGE
  fi

  echo -e "\nBuilding $PACKAGE\n"

  cd $HOME/git/$PACKAGE
  makepkg -si --noconfirm
done

# Installing packages/dependencies
echo -e "\nInstalling Dependencies\n"
sudo pacman -S --noconfirm --needed \
  xf86-video-intel \
  xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libx11 libxft \
  xcalib \
  ttf-font-awesome \
  nautilus \
  neovim \
  vifm \
  openssh \
  htop \
  firefox \
  rxvt-unicode \
  feh \
  imagemagick \
  pulseaudio \
  pavucontrol \
  tldr \
  inkscape \
  code \
  zathura \
  neofetch

# Enabling services
# systemctl enable ntpd

# Compiling suckless tools
for tool in dmenu dwm
do 
  cd $HOME/.local/src/$tool
  sudo make clean install
done

# Source bash configuration
source $HOME/.bashrc

# Installing development environments
# NEED Ruby env
# NEED Lamp stack with php 7

# Return home so new shells open at home
cd $HOME

startx
