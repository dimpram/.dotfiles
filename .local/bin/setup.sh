#!/bin/sh
# -----------------------------------------------------------------------------
# Author: @dimpram
# Notes:
#
# Before executing the script make sure to do the following things while
# chrooted
# - Create user
# - Install network manager and start the service
# - Install intel microcode  
#
# Once you've cloned https://github.com/dimpram/.dotfiles.git to
# $HOME/git/.dotfiles - run this script to install everything else.
# -----------------------------------------------------------------------------

dependencies=(
  xf86-video-intel
  xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libx11 libxft libxinerama light
  xcalib xclip
  libnotify dunst
  vifm nautilus vlc
  openssh unzip zip scrot htop
  firefox
  android-tools
  rxvt-unicode rofi
  feh imagemagick
  acpi alsa-utils pulseaudio pavucontrol tlp ntfs-3g
  tldr tree
  inkscape
  libreoffice
  neofetch
  curl wget
  zsh zsh-completions zsh-syntax-highlighting
  bluez bluez-utils blueman
  signal-desktop
)

aur=(
  yay
  ttf-merriweather
  ttf-merriweather-sans
  ttf-oswald
  ttf-quintessential
  ttf-signika 
  ttf-google-fonts-git
  simple-mtpfs
  bashmount
  picom-ibhagwan-git
  urxvt-resize-font-git
  nerd-fonts-fira-code
)


# build_pkg builds and installs any package that's not from the main arch repo (e.g. AUR, Github etc)
# $1 : repo domain
# $2 : package list/array
# $3 : install command
build_pkg() {
  for PACKAGE in $2
  do
    if [ ! -d "$HOME/git/$PACKAGE/" ]
    then
      echo -e "\nCloning $PACKAGE\n"
      git clone https://$1/$PACKAGE.git $HOME/git/$PACKAGE
    fi

    echo -e "\nBuilding $PACKAGE\n"

    cd $HOME/git/$PACKAGE
    $3
    cd $HOME/git
    rm -rf $HOME/git/$PACKAGE
  done
}

set -e                                      # When any command fails the shell immediately shall exit

# Update Arch
echo -e "\nUpdating Arch\n"
sudo pacman -Syu --noconfirm 


# Stow files
echo -e "\nStowing Dotfiles\n"
mkdir -p $HOME/.config                      # Make the config folder so stowing everything doesn't just symlink the folder
mkdir -p $HOME/.local                       # Make the config folder so stowing everything doesn't just symlink the folder
sudo pacman -S stow --noconfirm --needed    # Installing stow
cd $HOME/git
stow .dotfiles                              # Stowing the .dotfiles folder

# Install AUR Dependencies
echo -e "\nInstalling AUR dependencies\n"
sudo pacman -S --noconfirm vim base-devel --needed  # Installing base-devel if it's not installed already (This package contains everything required to build from the AUR)

# Build aur packages
build_pkg "aur.archlinux.org" $aur "makepkg -si --noconfirm"

# Install packages/dependencies
echo -e "\nInstalling dependencies\n"
sudo pacman -S --noconfirm --needed $dependencies

# Install dwm
echo -e "\Installing DWM\n"
cd .local/src/dwm
sudo make clean install

# Enable services
echo -e "\Enabling services\n"
sudo systemctl enable systemd-timesyncd.service # For Time synchronization
sudo systemctl enable bluetooth.service         # For Bluetooth service
sudo systemctl enable tlp.service               # For power management

# Install development environments
# Ruby
echo -e "\Installing Ruby\n"
build_pkg "aur.archlinux.org" "rbenv ruby-build" "makepkg -si --noconfirm"
rbenv init 

# Golang
echo -e "\Installing Golang\n"
sudo pacman -S --noconfirm --needed go go-tools
mkdir -p ~/go/src

# Install nvim config
echo -e "\Installing neovim configs\n"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c ":PlugInstall"

# Install MacOS WhiteSur theme + WhiteSur icons
echo -e "\Installing WhiteSur theme\n"
build_pkg "github.com" "vinceliuice/WhiteSur-gtk-theme vinceliuice/WhiteSur-icon-theme" "/install.sh"

cd $HOME                                    # Return home so new shells open at home
startx                                      # Start xserver

# Post Installation
# feh --bg-fill $HOME/wals/mac.jpg

# Switch to zsh make that a separate script
# rm -f $HOME/.bashrc $HOME/.bash_profile     # Sometimes there's a bashrc or a bash_profile
# chsh -s /usr/bin/zsh
# source $HOME/.zsh

## Xiaomi optimizations

# Install intel driver and disable nvdia

# Read this: https://github.com/Askannz/optimus-manager

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

# Misc
# Command for updating git submodules
# git submodule foreach git pull     

