# ~/.dotfiles

![Preview](https://user-images.githubusercontent.com/44473195/128847571-0301a148-1265-4467-b094-a296142948d5.png)



My configuration files for my 2021 Arch Linux rice which is based around Mac OS Big Sur. This configuration runs currently on my Xiaomi MI Air 13.3 2018 global edition and thus the bootstraping script contains some optional optimizations (disable nvidia GPU, screen calibration, drivers, keyboard...) that you can install in case that you have the same laptop.

## Programs

+ __WM:__ [dwm](https://dwm.suckless.org/) + [fullgaps](https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.2.diff) + [actualfullscreen](https://dwm.suckless.org/patches/actualfullscreen/dwm-actualfullscreen-20191112-cb3f58a.diff) + [attachbottom](https://dwm.suckless.org/patches/attachbottom/dwm-attachbottom-6.2.diff) + [cfacts](https://dwm.suckless.org/patches/cfacts/dwm-cfacts-6.2-1.diff)
+ __Compositor:__ [ibhagwan/picom (for rounded corners)](https://github.com/ibhagwan/picom)
+ __GTK theme:__ [WhiteSur](https://github.com/vinceliuice/WhiteSur-gtk-theme)
+ __Launcher:__ [rofi (spotlight dark LR-tech theme)](https://github.com/lr-tech/rofi-themes-collection#squared-red)
+ __Notifications:__ [dunst](https://dunst-project.org/)
+ __Terminal:__ [urxvt](https://wiki.archlinux.org/title/Rxvt-unicode) + zsh
+ __Editor:__ [Custom NvChad](https://github.com/dimpram/NvChad), [vscode OSS](https://code.visualstudio.com/)
+ __Image Viewer:__ [feh](https://feh.finalrewind.org/)
+ __File Manager:__ [vifm](https://vifm.info/)
+ __Browser:__ [firefox](https://www.mozilla.org/en-US/firefox/new/)
+ __Power:__ [tlp](https://wiki.archlinux.org/index.php/TLP)
+ __Hardware:__ [bashmount](https://github.com/jamielinux/bashmount)

## Getting Started

In order to set up this rice you need to install Arch Linux and create a user. This can be done by following [the Arch Wiki](https://wiki.archlinux.org/index.php/Installation_guide).

Note: the automatic bootstrap script uses `sudo`, so you'll need to ensure your user is apart of the `wheel` group.

After installing everything and creating your user, clone the `.dotfiles` repo to `~/git/.dotfiles`.
```
mkdir -p ~/git
git clone https://github.com/jimDragon/.dotfiles.git ~/git/.dotfiles
```

After cloning the respository run the bootstrap script and follow the prompts.
```
~/git/.dotfiles/.local/bin/installenv.sh
```

Once this script completes you'll be loaded into my build of dwm window manager with everything configured according to my configs (and preferences).

### Manual

If you don't want to use the automatic script, symlink all the files to your home directory using the command `stow`.
```
cd ~/git
stow .dotfiles
```
Now that the config files are stowed, the environment should mostly be up and running.


#### Dependencies
There are various dependencies that are required to get this rice working perfectly. Most are in the Arch repos but you will need to install some stuff form the AUR. If you're setting this rice up on another distro just install the same applications with the equivalent commands.

Note: if you're using the automatic script you don't have to worry about installing these manually. You can modify the script and make your own bootstrap script pretty easily :)

## Notes

I decided to remove GTK Gruvbox theme because the way i had it setup wasn't very clean. It's up to you know to enable a GTK theme of your choice :)
