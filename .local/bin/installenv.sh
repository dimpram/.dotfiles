#!/bin/sh

# Before executing the script make sure to do the following things while chrooted
# - Create user
# - Install network manager and start the service
# - Install intel microcode  

# Once you've cloned https://github.com/jimDragon/.dotfiles.git to
# $HOME/git/.dotfiles - run this script to install everything else.

set -e                                      # When any command fails the shell immediately shall exit,

# Updating Arch
echo -e "\nUpdating Arch\n"
sudo pacman -Syu --noconfirm

# Installing custom tty font
echo -e "\Set Terminus TTY Font\n"
sudo pacman -S --noconfirm terminus-font --needed
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
for PACKAGE in ttf-merriweather ttf-merriweather-sans ttf-oswald ttf-quintessential ttf-signika ttf-google-fonts-git brave-bin simple-mtpfs
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
  xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libx11 libxft libxinerama xorg-xbacklight \
  xcalib \
  ttf-font-awesome \
  libnotify dunst \
  neovim \
  vifm nautilus \
  openssh \
  htop \
  firefox \
  rxvt-unicode \
  feh \
  imagemagick \
  acpi alsa-utils pulseaudio pavucontrol \
  tldr \
  inkscape \
  code \
  zathura \
  neofetch \
  curl \
  zsh zsh-completions

# Enabling services
# no servive to be enabled

# Compiling suckless tools
for tool in dmenu slstatus dwm
do 
  cd $HOME/.local/src/$tool
  sudo make clean install
done

# Switch to zsh
chsh -s /usr/bin/zsh
source $HOME/.zsh

# Installing development environments
# NEED Ruby env
# NEED Lamp stack with php 7

# Return home so new shells open at home
cd $HOME

startx

# Intel microcode 
# Install intel driver
# sudo pacman -S xf86-video-intel


# Blacklist nvidia kernel modules
# sudo zsh -c "echo -e 'blacklist nouveau\nblacklist nvidia' > /etc/modprobe.d/nouveau.conf"
# install bbswitch to turn of the second nvidia gpu
# sudo zsh -c "echo -e 'options bbswitch load_state=0' > /etc/modprobe.d/bbswitch.conf"
# sudo zsh -c "echo -e 'bbswitch' > /etc/modules-load.d/bbswitch.conf"

# Configure touchpad
# sudo pacman -S xf86-input-libinput
# sudo zsh -c "echo -e 'Section "InputClass"\n\tIdentifier "libinput touchpad"\n\tDriver "libinput"\n\tMatchIsTouchpad "on"\n\tMatchDevicePath "/dev/input/event*"\n\tOption "Tapping" "on"\n\tOption "ClickMethod" "clickfinger"\n\tOption "NaturalScrolling" "true"\nEndSection' > /etc/X11/xorg.conf.d/20-touchpad.conf"

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
